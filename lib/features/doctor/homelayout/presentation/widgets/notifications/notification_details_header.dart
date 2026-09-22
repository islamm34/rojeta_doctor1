import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/time_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/doctor_notification_model.dart';

class NotificationDetailsHeader extends StatelessWidget {
  final DoctorNotificationModel notification;
  final VoidCallback onClose;

  const NotificationDetailsHeader({
    super.key,
    required this.notification,
    required this.onClose,
  });

  IconData _getIcon() {
    switch (notification.type) {
      case 'new_appointment':
      case 'appointment_request':
      case 'appointment_upcoming':
      case 'appointment_confirmed':
      case 'appointment_cancelled':
        return Icons.calendar_today_outlined;
      case 'payment':
        return Icons.account_balance_wallet_outlined;
      case 'patient_registered':
        return Icons.person_add_outlined;
      case 'review':
        return Icons.star_border_outlined;
      case 'message':
        return Icons.chat_bubble_outline;
      case 'reminder':
        return Icons.access_time;
      case 'system':
      default:
        return Icons.notifications_active_outlined;
    }
  }

  Color _getIconColor(BuildContext context) {
    switch (notification.type) {
      case 'appointment_cancelled':
        return Colors.red;
      case 'payment':
        return Colors.green;
      case 'review':
        return Colors.amber;
      case 'patient_registered':
        return Colors.purple;
      case 'message':
      case 'reminder':
      case 'system':
      case 'new_appointment':
      case 'appointment_request':
      case 'appointment_upcoming':
      case 'appointment_confirmed':
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = _getIconColor(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(_getIcon(), color: iconColor, size: 24),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                notification.time.isNotEmpty
                    ? TimeFormatter.formatDateTime(
                        notification.time,
                        null,
                        context: context,
                      )
                    : (notification.timeAgo ?? ''),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close),
          color: Colors.grey.shade600,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
