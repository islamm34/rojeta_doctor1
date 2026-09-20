import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../../models/doctor_notification_model.dart';

abstract class DoctorNotificationsRemoteDataSource {
  Future<List<DoctorNotificationModel>> getNotifications({
    int? page,
    int? limit,
    bool? isRead,
    String? type,
  });

  Future<void> markAsRead(String notificationId);
}

class DoctorNotificationsRemoteDataSourceImpl
    implements DoctorNotificationsRemoteDataSource {
  final ApiConsumer apiConsumer;

  DoctorNotificationsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<DoctorNotificationModel>> getNotifications({
    int? page,
    int? limit,
    bool? isRead,
    String? type,
  }) async {
    final query = <String, dynamic>{};
    if (page != null) query['page'] = page;
    if (limit != null) query['limit'] = limit;
    if (isRead != null) query['isRead'] = isRead;
    if (type != null && type.isNotEmpty && type.toLowerCase() != 'all') {
      query['type'] = type;
    }

    // 1. Try dedicated notifications endpoints
    final notifEndpoints = [
      Endpoints.doctorNotifications,
      '/lab/notifications',
      '/radiology/notifications',
      Endpoints.notifications,
      '/notifications',
    ];

    for (final ep in notifEndpoints) {
      try {
        final response = await apiConsumer.get(
          ep,
          queryParameters: query.isNotEmpty ? query : null,
        );

        final rawList =
            response is Map<String, dynamic> && response['data'] is List
                ? response['data'] as List<dynamic>
                : (response is List ? response : <dynamic>[]);

        final list = rawList
            .whereType<Map<String, dynamic>>()
            .map((e) => DoctorNotificationModel.fromJson(e))
            .toList();

        if (list.isNotEmpty) return list;
      } catch (_) {
        // Try next endpoint
      }
    }

    // 2. Fallback: synthesize notifications from recent bookings (for lab/radiology) or doctor appointments
    final bookingEndpoints = [
      Endpoints.bookings,
      Endpoints.doctorAppointments,
    ];

    for (final bEp in bookingEndpoints) {
      try {
        final apptResponse = await apiConsumer.get(bEp);
        final rawList = apptResponse is Map<String, dynamic> &&
                apptResponse['data'] is List
            ? apptResponse['data'] as List<dynamic>
            : (apptResponse is List ? apptResponse : <dynamic>[]);

        if (rawList.isEmpty) continue;

        final notifications = <DoctorNotificationModel>[];
        for (final item in rawList.whereType<Map<String, dynamic>>()) {
          final id = (item['id'] ?? item['_id'] ?? item['bookingRefId'] ?? '').toString();
          final patientObj = item['patient'] as Map<String, dynamic>?;
          final patientName = (patientObj?['name'] ??
                  item['patient_name'] ??
                  item['patientName'] ??
                  'Patient')
              .toString();
          final date = (item['date'] ??
                  item['booking_date'] ??
                  item['appointment_date'] ??
                  item['created_at'] ??
                  '')
              .toString();
          final status = (item['status'] ?? 'pending').toString();
          final paymentStatus =
              (item['payment_status'] ?? item['paymentStatus'] ?? '').toString();

          notifications.add(
            DoctorNotificationModel(
              id: 'notif_$id',
              title: status.toLowerCase() == 'confirmed'
                  ? 'Booking Confirmed'
                  : 'Booking Update',
              body: 'Booking for $patientName on $date (${status.toUpperCase()}) - Payment: $paymentStatus',
              time: date,
              isRead: false,
              priority: status.toLowerCase() == 'pending' ? 'High' : 'Medium',
              type: 'appointment',
            ),
          );
        }

        if (notifications.isNotEmpty) return notifications;
      } catch (_) {
        // Try next fallback
      }
    }

    return <DoctorNotificationModel>[];
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    final readEndpoints = [
      Endpoints.doctorNotificationRead(notificationId),
      '/notifications/$notificationId/read',
      '/notifications/read/$notificationId',
      '/lab/notifications/$notificationId/read',
    ];
    for (final ep in readEndpoints) {
      try {
        await apiConsumer.patch(ep);
        return;
      } catch (_) {
        try {
          await apiConsumer.post(ep);
          return;
        } catch (_) {}
      }
    }
  }
}
