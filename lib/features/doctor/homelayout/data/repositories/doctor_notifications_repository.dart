import '../datasources/remote/doctor_notifications_remote_data_source.dart';
import '../models/doctor_notification_model.dart';

abstract class DoctorNotificationsRepository {
  Future<List<DoctorNotificationModel>> getNotifications({
    int? page,
    int? limit,
    bool? isRead,
    String? type,
  });

  Future<void> markAsRead(String notificationId);
}

class DoctorNotificationsRepositoryImpl
    implements DoctorNotificationsRepository {
  final DoctorNotificationsRemoteDataSource remoteDataSource;

  DoctorNotificationsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<DoctorNotificationModel>> getNotifications({
    int? page,
    int? limit,
    bool? isRead,
    String? type,
  }) =>
      remoteDataSource.getNotifications(
        page: page,
        limit: limit,
        isRead: isRead,
        type: type,
      );

  @override
  Future<void> markAsRead(String notificationId) =>
      remoteDataSource.markAsRead(notificationId);
}
