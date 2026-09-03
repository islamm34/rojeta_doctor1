import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/repositories/doctor_notifications_repository.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final DoctorNotificationsRepository repository;

  NotificationsCubit({required this.repository})
    : super(const NotificationsState()) {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    emit(
      state.copyWith(status: NotificationsStatus.loading, errorMessage: null),
    );

    try {
      final notifications = await repository.getNotifications();
      emit(
        state.copyWith(
          status: NotificationsStatus.success,
          notifications: notifications,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NotificationsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void setFilter(NotificationFilter filter) {
    emit(state.copyWith(filter: filter));
  }

  Future<void> markAsRead(String id) async {
    final updatedList = state.notifications.map((n) {
      if (n.id == id) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();

    emit(state.copyWith(notifications: updatedList));

    try {
      await repository.markAsRead(id);
    } catch (_) {}
  }

  Future<void> markAllAsRead() async {
    final unreadList = state.notifications
        .where((n) => !n.isRead)
        .map((n) => n.id)
        .toList();

    final updatedList = state.notifications.map((n) {
      return n.copyWith(isRead: true);
    }).toList();

    emit(state.copyWith(notifications: updatedList));

    for (final id in unreadList) {
      try {
        await repository.markAsRead(id);
      } catch (_) {}
    }
  }

  void deleteNotification(String id) {
    final updatedList = state.notifications.where((n) => n.id != id).toList();
    emit(state.copyWith(notifications: updatedList));
  }
}
