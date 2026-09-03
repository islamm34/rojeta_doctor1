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

    final response = await apiConsumer.get(
      Endpoints.doctorNotifications,
      queryParameters: query.isNotEmpty ? query : null,
    );

    final rawList = response is Map<String, dynamic> && response['data'] is List
        ? response['data'] as List<dynamic>
        : (response is List ? response : <dynamic>[]);

    return rawList
        .whereType<Map<String, dynamic>>()
        .map((e) => DoctorNotificationModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await apiConsumer.patch(
      Endpoints.doctorNotificationRead(notificationId),
    );
  }
}
