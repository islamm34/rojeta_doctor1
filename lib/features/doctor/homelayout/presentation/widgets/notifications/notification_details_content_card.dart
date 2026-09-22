import 'package:flutter/material.dart';

import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/doctor_notification_model.dart';

class NotificationDetailsContentCard extends StatelessWidget {
  final DoctorNotificationModel notification;

  const NotificationDetailsContentCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        notification.body,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: Colors.grey.shade800,
          height: 1.5,
          fontSize: 14,
        ),
      ),
    );
  }
}
