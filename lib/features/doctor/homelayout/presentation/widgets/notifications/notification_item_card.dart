import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/doctor_notification_model.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/extensions/time_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../bloc/notifications/notifications_cubit.dart';
import 'notification_details_dialog.dart';

class NotificationItemCard extends StatelessWidget {
  final DoctorNotificationModel notification;

  const NotificationItemCard({super.key, required this.notification});

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

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: notification.isRead
              ? Colors.grey.shade200
              : theme.colorScheme.primary.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => NotificationDetailsDialog.show(context, notification),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(_getIcon(), color: iconColor, size: 20),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  notification.title,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
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
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              if (!notification.isRead)
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            notification.body,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade700,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            notification.time.isNotEmpty
                                ? TimeFormatter.formatDateTime(
                                    notification.time,
                                    null,
                                    context: context,
                                  )
                                : (notification.timeAgo ?? ''),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => NotificationDetailsDialog.show(
                          context,
                          notification,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: Text(context.strings.viewDetails),
                      ),
                    ),
                    if (!notification.isRead) ...[
                      SizedBox(width: 12.w),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            context.read<NotificationsCubit>().markAsRead(
                              notification.id,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey.shade700,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: Text(context.strings.markAsRead),
                        ),
                      ),
                    ],
                    SizedBox(width: 12.w),
                    InkWell(
                      onTap: () {
                        context.read<NotificationsCubit>().deleteNotification(
                          notification.id,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
