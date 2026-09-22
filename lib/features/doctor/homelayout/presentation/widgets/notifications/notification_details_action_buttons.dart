import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/doctor_notification_model.dart';
import '../../bloc/notifications/notifications_cubit.dart';

class NotificationDetailsActionButtons extends StatelessWidget {
  final DoctorNotificationModel notification;

  const NotificationDetailsActionButtons({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasAppointment =
        notification.appointmentId != null &&
        notification.appointmentId!.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasAppointment) ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (!notification.isRead) {
                  context.read<NotificationsCubit>().markAsRead(
                    notification.id,
                  );
                }
                Navigator.of(context).pop();
                context.pushNamed(
                  AppRoutes.appointmentDetails,
                  extra: notification.appointmentId!,
                );
              },
              icon: const Icon(Icons.calendar_today_outlined, size: 18),
              label: Text(context.strings.appointmentDetails),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
        Row(
          children: [
            if (!notification.isRead) ...[
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.read<NotificationsCubit>().markAsRead(
                      notification.id,
                    );
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.done_all, size: 16),
                  label: Text(context.strings.markAsRead),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.colorScheme.primary,
                    side: BorderSide(
                      color: theme.colorScheme.primary.withValues(alpha: 0.5),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
            ],
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  context.read<NotificationsCubit>().deleteNotification(
                    notification.id,
                  );
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete_outline, size: 16),
                label: Text(context.strings.delete),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: BorderSide(color: Colors.red.withValues(alpha: 0.3)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
              style: IconButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
                foregroundColor: Colors.grey.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              tooltip: context.strings.close,
            ),
          ],
        ),
      ],
    );
  }
}
