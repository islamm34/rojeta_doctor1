import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/doctor_notification_model.dart';

class NotificationDetailsBadges extends StatelessWidget {
  final DoctorNotificationModel notification;

  const NotificationDetailsBadges({super.key, required this.notification});

  Color _getPriorityColor() {
    switch (notification.priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
      default:
        return Colors.grey.shade600;
    }
  }

  Color _getPriorityBgColor() {
    switch (notification.priority) {
      case 'High':
        return Colors.red.withValues(alpha: 0.1);
      case 'Medium':
        return Colors.orange.withValues(alpha: 0.1);
      case 'Low':
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 8.w,
      runSpacing: 6.h,
      children: [
        // Priority Badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: _getPriorityBgColor(),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            notification.priority == 'High'
                ? context.strings.high
                : (notification.priority == 'Medium'
                      ? context.strings.medium
                      : context.strings.low),
            style: theme.textTheme.bodySmall?.copyWith(
              color: _getPriorityColor(),
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),

        // Read / Unread status badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: notification.isRead
                ? Colors.grey.shade100
                : theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: notification.isRead
                      ? Colors.grey.shade400
                      : theme.colorScheme.primary,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                notification.isRead
                    ? context.strings.markAsRead
                    : context.strings.unread,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: notification.isRead
                      ? Colors.grey.shade600
                      : theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
