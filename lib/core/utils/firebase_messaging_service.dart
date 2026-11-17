import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../di/injector.dart';
import '../network/api_consumer.dart';
import '../network/endpoints.dart';
import '../utils/flutter_secure_storage_helper.dart';
import '../../config/routes/app_router.dart';
import '../../main.dart';
import 'local_notification_service.dart';

class NotificationDisplayData {
  final String title;
  final String body;

  const NotificationDisplayData({required this.title, required this.body});
}

/// Top-level background message handler required by Firebase Messaging
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('🔥 [FCM Background Message] Message ID: ${message.messageId}');
  log('🔥 [FCM Background Message] Data: ${message.data}');
  if (message.notification != null) {
    log(
      '🔥 [FCM Background Message] Title: ${message.notification?.title}, Body: ${message.notification?.body}',
    );
  } else {
    try {
      final displayData =
          FirebaseMessagingService.formatIncomingBookingNotification(message);
      final payload = message.data.map(
        (key, value) => MapEntry(key, value.toString()),
      );
      payload['title'] = displayData.title;
      payload['body'] = displayData.body;

      await LocalNotificationService.showNotification(
        id: message.hashCode,
        title: displayData.title,
        body: displayData.body,
        payload: payload,
      );
    } catch (e) {
      log('Error showing background notification: $e');
    }
  }
}

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final ApiConsumer? apiConsumer;

  FirebaseMessagingService({this.apiConsumer});

  /// Stream that emits foreground FCM messages so BLoCs/Screens can react
  final StreamController<RemoteMessage> _foregroundMessageController =
      StreamController<RemoteMessage>.broadcast();

  Stream<RemoteMessage> get onForegroundMessage =>
      _foregroundMessageController.stream;

  Future<void> init() async {
    // Initialize LocalNotificationService for foreground notification popups
    await LocalNotificationService.init();

    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Request notification permissions
    await _requestPermission();

    // Enable foreground notification presentation options (iOS/Android)
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Setup message listeners
    _setupForegroundListener();
    _setupMessageOpenedAppListener();

    // Check if app was opened from terminated state via notification click
    final RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();
    if (initialMessage != null) {
      _handleMessageClick(initialMessage);
    }

    // Fetch and log initial token & attempt backend sync if logged in
    final token = await getToken();
    if (token != null && token.isNotEmpty) {
      await sendDeviceTokenToBackend(token);
    }

    // Listen for token refreshes
    _listenToTokenRefresh();
  }

  Future<void> _requestPermission() async {
    final NotificationSettings settings = await _firebaseMessaging
        .requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );

    log('🔔 [FCM Permission Status]: ${settings.authorizationStatus}');
  }

  Future<String?> getToken() async {
    try {
      final String? token = await _firebaseMessaging.getToken();
      debugPrint('======================================================');
      debugPrint('🔥 [FCM TOKEN - DOCTOR APP]');
      debugPrint('$token');
      debugPrint('======================================================');
      log('🔥 [FCM TOKEN]: $token');
      return token;
    } catch (e, st) {
      debugPrint('❌ [FCM Error] Failed to get FCM token: $e');
      log('Error getting FCM token: $e\n$st');
      return null;
    }
  }

  /// Sends the FCM device token to the backend server.
  /// Triggered automatically after login, registration, OTP verification, app launch, and token refresh.
  Future<void> sendDeviceTokenToBackend([String? token]) async {
    try {
      final authToken = await FlutterSecureStorageHelper.getToken();
      if (authToken == null || authToken.trim().isEmpty) {
        debugPrint(
          'ℹ️ [FCM] User not authenticated yet; skipping device token backend sync.',
        );
        return;
      }

      final fcmToken = token ?? await getToken();
      if (fcmToken == null || fcmToken.trim().isEmpty) {
        debugPrint(
          '⚠️ [FCM] FCM Token is null or empty, cannot sync with backend.',
        );
        return;
      }

      final deviceType = defaultTargetPlatform == TargetPlatform.iOS
          ? 'ios'
          : 'android';
      final payload = {'token': fcmToken, 'device_type': deviceType};

      debugPrint('🚀 [FCM] Registering Device Token with Backend: $payload');

      final consumer =
          apiConsumer ??
          (injector.isRegistered<ApiConsumer>()
              ? injector<ApiConsumer>()
              : null);

      if (consumer == null) {
        debugPrint('⚠️ [FCM] ApiConsumer is not available.');
        return;
      }

      // Try doctor device token endpoint first, fallback to general notifications endpoint
      try {
        await consumer.post(Endpoints.doctorDeviceToken, data: payload);
        debugPrint(
          '✅ [FCM] Device Token registered successfully on ${Endpoints.doctorDeviceToken}',
        );
      } catch (e) {
        debugPrint(
          '⚠️ [FCM] Endpoint ${Endpoints.doctorDeviceToken} failed ($e). Trying fallback: ${Endpoints.notificationsDeviceToken}',
        );
        try {
          await consumer.post(
            Endpoints.notificationsDeviceToken,
            data: payload,
          );
          debugPrint(
            '✅ [FCM] Device Token registered successfully on fallback: ${Endpoints.notificationsDeviceToken}',
          );
        } catch (fallbackError) {
          debugPrint(
            '❌ [FCM Error] Both device token endpoints failed: $fallbackError',
          );
        }
      }
    } catch (e, st) {
      debugPrint(
        '❌ [FCM Error] Unexpected error in sendDeviceTokenToBackend: $e',
      );
      log('FCM backend sync error: $e\n$st');
    }
  }

  void _listenToTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      debugPrint('======================================================');
      debugPrint('🔄 [FCM TOKEN REFRESHED - DOCTOR APP]');
      debugPrint(newToken);
      debugPrint('======================================================');
      log('🔄 [FCM TOKEN REFRESHED]: $newToken');
      sendDeviceTokenToBackend(newToken);
    });
  }

  Stream<String> get onTokenRefresh => _firebaseMessaging.onTokenRefresh;

  static NotificationDisplayData formatIncomingBookingNotification(
    RemoteMessage message,
  ) {
    final data = message.data;
    final patientName =
        (data['patient_name'] ??
                data['patientName'] ??
                data['patient']?['name'] ??
                data['name'] ??
                data['userName'] ??
                data['user_name'])
            ?.toString()
            .trim();

    final phone =
        (data['patient_phone'] ??
                data['patientPhone'] ??
                data['phone'] ??
                data['contact_phone'] ??
                data['patient']?['phone'])
            ?.toString()
            .trim();

    final date =
        (data['date'] ??
                data['booking_date'] ??
                data['appointment_date'] ??
                data['day'])
            ?.toString()
            .trim();

    final time =
        (data['time'] ?? data['booking_time'] ?? data['appointment_time'])
            ?.toString()
            .trim();

    final notes =
        (data['notes'] ??
                data['reason'] ??
                data['complaint'] ??
                data['patient_notes'] ??
                data['symptoms'] ??
                data['medical_condition'])
            ?.toString()
            .trim();

    final location =
        (data['location'] ??
                data['clinic_name'] ??
                data['clinic_address'] ??
                data['address'] ??
                data['area'])
            ?.toString()
            .trim();

    final fee =
        (data['fee'] ??
                data['price'] ??
                data['total_amount'] ??
                data['total_price'] ??
                data['amount'] ??
                data['consultation_fee'])
            ?.toString()
            .trim();

    final paymentMethod =
        (data['payment_method'] ??
                data['paymentMethod'] ??
                data['payment_type'] ??
                data['payment'])
            ?.toString()
            .trim();

    final rawTitle =
        message.notification?.title ?? data['title']?.toString() ?? '';
    final rawBody =
        message.notification?.body ?? data['body']?.toString() ?? '';

    final hasPatientInfo = patientName != null && patientName.isNotEmpty;
    final typeStr = (data['type'] ?? data['notification_type'] ?? '')
        .toString()
        .toLowerCase();
    final isPayment =
        typeStr == 'payment' ||
        typeStr == 'payment_received' ||
        typeStr == 'payment_success' ||
        typeStr == 'cash_payment_confirmed' ||
        data.containsKey('amount_paid') ||
        rawTitle.toLowerCase().contains('payment') ||
        rawTitle.contains('دفع') ||
        rawBody.contains('تم دفع') ||
        rawBody.contains('استلام دفعة');

    if (isPayment) {
      final amountPaid = data['amount_paid']?.toString() ?? fee;
      final bookingId =
          (data['booking_id'] ??
                  data['bookingId'] ??
                  data['appointment_id'] ??
                  data['appointmentId'] ??
                  data['id'])
              ?.toString();

      final payTitle = hasPatientInfo
          ? '💰 تم استلام دفعة جديدة من $patientName'
          : (rawTitle.isNotEmpty ? rawTitle : '💰 تم استلام دفعة جديدة');

      final lines = <String>[];
      if (hasPatientInfo) {
        lines.add('👤 المريض: $patientName');
      }
      if (amountPaid != null && amountPaid.isNotEmpty) {
        lines.add('💵 المبلغ المدفوع: $amountPaid ج.م');
      }
      if (paymentMethod != null && paymentMethod.isNotEmpty) {
        final pmClean = paymentMethod.toLowerCase().contains('card')
            ? 'بطاقة ائتمان'
            : (paymentMethod.toLowerCase().contains('cash')
                  ? 'نقدي'
                  : paymentMethod);
        lines.add('💳 طريقة الدفع: $pmClean');
      }
      if (bookingId != null && bookingId.isNotEmpty) {
        lines.add('📋 رقم الحجز: #$bookingId');
      }

      final payBody = lines.isNotEmpty
          ? lines.join('\n')
          : (rawBody.isNotEmpty ? rawBody : 'تم استلام دفعة مالية جديدة بنجاح');

      return NotificationDisplayData(title: payTitle, body: payBody);
    }

    final isBooking =
        data.containsKey('booking_id') ||
        data.containsKey('appointment_id') ||
        data['type'] == 'booking' ||
        data['type'] == 'new_booking' ||
        data['type'] == 'appointment' ||
        data['type'] == 'new_appointment' ||
        hasPatientInfo;

    if (!isBooking && !hasPatientInfo) {
      return NotificationDisplayData(
        title: rawTitle.isNotEmpty ? rawTitle : 'إشعار جديد',
        body: rawBody,
      );
    }

    final title = hasPatientInfo
        ? 'طلب حجز جديد من $patientName'
        : (rawTitle.isNotEmpty ? rawTitle : 'طلب حجز جديد');

    final lines = <String>[];
    if (hasPatientInfo) {
      lines.add('👤 المريض: $patientName');
    }
    if (phone != null && phone.isNotEmpty) {
      lines.add('📞 الهاتف: $phone');
    }
    if ((date != null && date.isNotEmpty) ||
        (time != null && time.isNotEmpty)) {
      final dt = [
        if (date != null && date.isNotEmpty) date,
        if (time != null && time.isNotEmpty) time,
      ].join(' - ');
      lines.add('📅 الموعد: $dt');
    }
    if (location != null && location.isNotEmpty) {
      lines.add('📍 العيادة: $location');
    }
    if (notes != null && notes.isNotEmpty) {
      lines.add('📝 الشكوى: $notes');
    }
    if (fee != null && fee.isNotEmpty) {
      final payStr = paymentMethod != null && paymentMethod.isNotEmpty
          ? ' ($paymentMethod)'
          : '';
      lines.add('💵 الرسوم: $fee ج.م$payStr');
    }

    final body = lines.isNotEmpty
        ? lines.join('\n')
        : (rawBody.isNotEmpty ? rawBody : 'لديك طلب حجز جديد بانتظار التأكيد');

    return NotificationDisplayData(title: title, body: body);
  }

  void _setupForegroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📩 [FCM Foreground Message Received]');
      debugPrint('Title: ${message.notification?.title}');
      debugPrint('Body: ${message.notification?.body}');
      debugPrint('Data: ${message.data}');

      // Emit to stream listeners
      _foregroundMessageController.add(message);

      // Display system notification banner / popup in foreground with patient name & details
      final displayData = formatIncomingBookingNotification(message);

      if (displayData.title.isNotEmpty || displayData.body.isNotEmpty) {
        final payload = message.data.map(
          (key, value) => MapEntry(key, value.toString()),
        );
        payload['title'] = displayData.title;
        payload['body'] = displayData.body;

        LocalNotificationService.showNotification(
          id: message.hashCode,
          title: displayData.title,
          body: displayData.body,
          payload: payload,
        );
      }
    });
  }

  void _setupMessageOpenedAppListener() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('📲 [FCM Notification Clicked (Background)]');
      _handleMessageClick(message);
    });
  }

  void _handleMessageClick(RemoteMessage message) {
    debugPrint('👉 [FCM Handling Message Open]: ${message.messageId}');
    debugPrint('Data payload: ${message.data}');

    final bookingId =
        message.data['booking_id'] ??
        message.data['appointment_id'] ??
        message.data['id'] ??
        message.data['bookingRef'];
    final type = message.data['type'];
    final role = message.data['role'];
    final route = message.data['route'];

    debugPrint(
      '🎯 [FCM Routing Target] Role: $role, Type: $type, ID: $bookingId, Route: $route',
    );

    if (bookingId != null && bookingId.toString().isNotEmpty) {
      RojetaDoctorApp.navigatorKey.currentState?.pushNamed(
        AppRoutes.appointmentDetails,
        arguments: bookingId.toString(),
      );
    }
  }

  void dispose() {
    _foregroundMessageController.close();
  }
}
