import 'package:equatable/equatable.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/doctor_notification_model.dart';

enum NotificationsStatus { initial, loading, success, failure }

enum NotificationFilter { all, unread, urgent }

class NotificationsState extends Equatable {
  final NotificationsStatus status;
  final List<DoctorNotificationModel> notifications;
  final NotificationFilter filter;
  final String? errorMessage;

  const NotificationsState({
    this.status = NotificationsStatus.initial,
    this.notifications = const [],
    this.filter = NotificationFilter.all,
    this.errorMessage,
  });

  List<DoctorNotificationModel> get filteredNotifications {
    switch (filter) {
      case NotificationFilter.all:
        return notifications;
      case NotificationFilter.unread:
        return notifications.where((n) => !n.isRead).toList();
      case NotificationFilter.urgent:
        return notifications.where((n) => n.priority == 'High').toList();
    }
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;
  int get urgentCount =>
      notifications.where((n) => n.priority == 'High').length;

  NotificationsState copyWith({
    NotificationsStatus? status,
    List<DoctorNotificationModel>? notifications,
    NotificationFilter? filter,
    String? errorMessage,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      filter: filter ?? this.filter,
      // Error message is explicitly reset if status transitions away from failure, unless provided
      errorMessage:
          status != NotificationsStatus.failure && errorMessage == null
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, notifications, filter, errorMessage];
}
