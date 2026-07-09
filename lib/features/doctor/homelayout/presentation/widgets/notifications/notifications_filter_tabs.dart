import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/notifications/notifications_cubit.dart';
import '../../bloc/notifications/notifications_state.dart';

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
              _buildTab(
                context,
                title: '${context.strings.all} ($allCount)',
                isSelected: state.filter == NotificationFilter.all,
                onTap: () => context.read<NotificationsCubit>().setFilter(NotificationFilter.all),
              ),
              _buildTab(
                context,
                title: '${context.strings.unread} ($unreadCount)',
                isSelected: state.filter == NotificationFilter.unread,
                onTap: () => context.read<NotificationsCubit>().setFilter(NotificationFilter.unread),
              ),
              _buildTab(
                context,
                title: '${context.strings.urgent} ($urgentCount)',
                isSelected: state.filter == NotificationFilter.urgent,
                onTap: () => context.read<NotificationsCubit>().setFilter(NotificationFilter.urgent),
                isUrgent: true,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    bool isUrgent = false,
  }) {
    final theme = Theme.of(context);
    
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected 
                  ? Colors.white 
                  : (isUrgent ? Colors.red : Colors.grey.shade600),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
