import '../../../../../../core/local/user_hive_helper.dart';
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

    final role = UserHiveHelper.getUser()?.role?.toLowerCase().trim() ?? '';
    final String endpoint = (role == 'doctor' || role.contains('doctor'))
        ? Endpoints.doctorNotifications
        : Endpoints.notifications;

    try {
      final response = await apiConsumer.get(
        endpoint,
        queryParameters: query.isNotEmpty ? query : null,
      );

      List<dynamic> rawList = [];
      if (response is List) {
        rawList = response;
      } else if (response is Map<String, dynamic>) {
        if (response['data'] is List) {
          rawList = response['data'] as List<dynamic>;
        } else if (response['data'] is Map<String, dynamic> &&
            response['data']['data'] is List) {
          rawList = response['data']['data'] as List<dynamic>;
        } else if (response['data'] is Map<String, dynamic> &&
            response['data']['notifications'] is List) {
          rawList = response['data']['notifications'] as List<dynamic>;
        } else if (response['notifications'] is List) {
          rawList = response['notifications'] as List<dynamic>;
        }
      }

      return rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => DoctorNotificationModel.fromJson(e))
          .toList();
    } catch (_) {
      return <DoctorNotificationModel>[];
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    final role = UserHiveHelper.getUser()?.role?.toLowerCase().trim() ?? '';
    final String endpoint = (role == 'doctor' || role.contains('doctor'))
        ? Endpoints.doctorNotificationRead(notificationId)
        : '/notifications/$notificationId/read';

    try {
      await apiConsumer.patch(endpoint);
    } catch (_) {
      try {
        await apiConsumer.post(endpoint);
      } catch (_) {}
    }
  }
}
