import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../di/injector.dart';
import '../network/api_consumer.dart';
import '../network/endpoints.dart';
import '../utils/flutter_secure_storage_helper.dart';
import 'local_notification_service.dart';

/// Top-level background message handler required by Firebase Messaging
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('🔥 [FCM Background Message] Message ID: ${message.messageId}');
  log('🔥 [FCM Background Message] Data: ${message.data}');
  if (message.notification != null) {
    log(
      '🔥 [FCM Background Message] Title: ${message.notification?.title}, Body: ${message.notification?.body}',
    );
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

  void _setupForegroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📩 [FCM Foreground Message Received]');
      debugPrint('Title: ${message.notification?.title}');
      debugPrint('Body: ${message.notification?.body}');
      debugPrint('Data: ${message.data}');

      // Emit to stream listeners
      _foregroundMessageController.add(message);

      // Display system notification banner / popup in foreground
      final title =
          message.notification?.title ?? message.data['title'] ?? 'إشعار جديد';
      final body = message.notification?.body ?? message.data['body'] ?? '';

      if (title.isNotEmpty || body.isNotEmpty) {
        LocalNotificationService.showNotification(
          id: message.hashCode,
          title: title,
          body: body,
          payload: message.data.map(
            (key, value) => MapEntry(key, value.toString()),
          ),
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
        message.data['id'];
    final type = message.data['type'];
    final role = message.data['role'];
    final route = message.data['route'];

    debugPrint(
      '🎯 [FCM Routing Target] Role: $role, Type: $type, ID: $bookingId, Route: $route',
    );
  }

  void dispose() {
    _foregroundMessageController.close();
  }
}
