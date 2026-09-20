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

    // 1. Try dedicated doctor notifications endpoint
    try {
      final response = await apiConsumer.get(
        Endpoints.doctorNotifications,
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
      // Try next fallback
    }

    // 2. Try general notifications endpoint
    try {
      final response = await apiConsumer.get(
        Endpoints.notifications,
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
      // Try next fallback
    }

    // 3. Fallback: synthesize notifications from recent appointments
    try {
      final apptResponse = await apiConsumer.get(Endpoints.doctorAppointments);
      final rawList = apptResponse is Map<String, dynamic> &&
              apptResponse['data'] is List
          ? apptResponse['data'] as List<dynamic>
          : (apptResponse is List ? apptResponse : <dynamic>[]);

      final notifications = <DoctorNotificationModel>[];
      for (final item in rawList.whereType<Map<String, dynamic>>()) {
        final id = (item['id'] ?? item['_id'] ?? '').toString();
        final patientObj = item['patient'] as Map<String, dynamic>?;
        final patientName = (patientObj?['name'] ??
                item['patient_name'] ??
                item['patientName'] ??
                'Patient')
            .toString();
        final date = (item['date'] ??
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
            title: status == 'confirmed'
                ? 'Appointment Confirmed'
                : 'Appointment Update',
            body: 'Appointment with $patientName on $date (${status.toUpperCase()}) - Payment: $paymentStatus',
            time: date,
            isRead: false,
            priority: status == 'pending' ? 'High' : 'Medium',
            type: 'appointment',
          ),
        );
      }

      return notifications;
    } catch (_) {
      return <DoctorNotificationModel>[];
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await apiConsumer.patch(
        Endpoints.doctorNotificationRead(notificationId),
      );
    } catch (_) {
      // Fallback or ignore if server does not implement read endpoint yet
    }
  }
}
