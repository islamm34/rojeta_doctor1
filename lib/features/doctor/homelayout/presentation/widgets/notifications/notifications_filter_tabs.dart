import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/notifications/notifications_cubit.dart';
import '../../bloc/notifications/notifications_state.dart';
import 'notification_filter_tab_item.dart';

class NotificationsFilterTabs extends StatelessWidget {
  const NotificationsFilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final int allCount = state.notifications.length;
        final int unreadCount = state.unreadCount;
        final int urgentCount = state.urgentCount;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              NotificationFilterTabItem(
                title: '${context.strings.all} ($allCount)',
                isSelected: state.filter == NotificationFilter.all,
                onTap: () => context.read<NotificationsCubit>().setFilter(
                  NotificationFilter.all,
                ),
              ),
              NotificationFilterTabItem(
                title: '${context.strings.unread} ($unreadCount)',
                isSelected: state.filter == NotificationFilter.unread,
                onTap: () => context.read<NotificationsCubit>().setFilter(
                  NotificationFilter.unread,
                ),
              ),
              NotificationFilterTabItem(
                title: '${context.strings.urgent} ($urgentCount)',
                isSelected: state.filter == NotificationFilter.urgent,
                onTap: () => context.read<NotificationsCubit>().setFilter(
                  NotificationFilter.urgent,
                ),
                isUrgent: true,
              ),
            ],
          ),
        );
      },
    );
  }
}
