import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'notification_tip_item.dart';

class NotificationManagementTips extends StatelessWidget {
  const NotificationManagementTips({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: 8.w),
              Text(
                context.strings.tipsForManagingNotifications,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          NotificationTipItem(
            text: context.strings.keepNotificationsTurnedOn,
          ),
          SizedBox(height: 8.h),
          NotificationTipItem(
            text: context.strings.markCompletedRequestsAsRead,
          ),
          SizedBox(height: 12.h),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: theme.colorScheme.primary,
                  size: 16,
                ),
                SizedBox(width: 4.w),
                Text(
                  context.strings.notificationSettings,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
