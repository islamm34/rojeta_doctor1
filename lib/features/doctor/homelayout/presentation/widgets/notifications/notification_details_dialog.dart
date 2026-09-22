import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/doctor_notification_model.dart';
import '../../bloc/notifications/notifications_cubit.dart';
import 'notification_details_action_buttons.dart';
import 'notification_details_badges.dart';
import 'notification_details_content_card.dart';
import 'notification_details_header.dart';
import 'notification_details_meta_section.dart';

class NotificationDetailsDialog extends StatelessWidget {
  final DoctorNotificationModel notification;

  const NotificationDetailsDialog({super.key, required this.notification});

  static Future<void> show(
    BuildContext context,
    DoctorNotificationModel notification,
  ) {
    final cubit = context.read<NotificationsCubit>();

    return showDialog<void>(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: cubit,
        child: NotificationDetailsDialog(notification: notification),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 480.w,
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NotificationDetailsHeader(
                  notification: notification,
                  onClose: () => Navigator.of(context).pop(),
                ),
                SizedBox(height: 12.h),
                NotificationDetailsBadges(notification: notification),
                SizedBox(height: 16.h),
                NotificationDetailsContentCard(notification: notification),
                SizedBox(height: 14.h),
                NotificationDetailsMetaSection(notification: notification),
                SizedBox(height: 20.h),
                NotificationDetailsActionButtons(notification: notification),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
