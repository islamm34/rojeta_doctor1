import 'package:flutter_bloc/flutter_bloc.dart';
import 'notifications_state.dart';
import '../../../../../../features/doctor/homelayout/data/mocks/doctor_mock_data.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsState()) {
    _loadNotifications();
  }

  void _loadNotifications() {
    emit(state.copyWith(status: NotificationsStatus.loading));

    try {
      // Simulate network delay
      Future.delayed(const Duration(milliseconds: 500), () {
        if (isClosed) return;
        emit(
          state.copyWith(
            status: NotificationsStatus.success,
            notifications: DoctorMockData.notifications,
          ),
        );
      });
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: NotificationsStatus.failure,
          errorMessage: 'Failed to load notifications',
        ),
      );
    }
  }

  void setFilter(NotificationFilter filter) {
    emit(state.copyWith(filter: filter));
  }

  void markAsRead(String id) {
    final updatedList = state.notifications.map((n) {
      if (n.id == id) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();

    emit(state.copyWith(notifications: updatedList));
  }

  void markAllAsRead() {
    final updatedList = state.notifications.map((n) {
      return n.copyWith(isRead: true);
    }).toList();

    emit(state.copyWith(notifications: updatedList));
  }

  void deleteNotification(String id) {
    final updatedList = state.notifications.where((n) => n.id != id).toList();
    emit(state.copyWith(notifications: updatedList));
  }
}
