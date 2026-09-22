import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/doctor_notification_model.dart';
import 'notification_detail_info_row.dart';

class NotificationDetailsMetaSection extends StatelessWidget {
  final DoctorNotificationModel notification;

  const NotificationDetailsMetaSection({super.key, required this.notification});

  String _formatBookingDate(String rawDate) {
    if (rawDate.contains(' ')) {
      return rawDate.split(' ').first;
    }
    if (rawDate.contains('T')) {
      return rawDate.split('T').first;
    }
    return rawDate;
  }

  @override
  Widget build(BuildContext context) {
    final hasPatientName =
        notification.patientName != null &&
        notification.patientName!.isNotEmpty;
    final hasPatientPhone =
        notification.patientPhone != null &&
        notification.patientPhone!.isNotEmpty;
    final hasBookingRef =
        notification.bookingRef != null && notification.bookingRef!.isNotEmpty;
    final hasBookingDate =
        notification.bookingDate != null &&
        notification.bookingDate!.isNotEmpty;
    final hasBookingTime =
        notification.bookingTime != null &&
        notification.bookingTime!.isNotEmpty;
    final hasVisitType =
        notification.visitType != null && notification.visitType!.isNotEmpty;

    final bool hasAnyMeta =
        hasPatientName ||
        hasPatientPhone ||
        hasBookingRef ||
        hasBookingDate ||
        hasBookingTime ||
        hasVisitType;

    if (!hasAnyMeta) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasPatientName)
            NotificationDetailInfoRow(
              icon: Icons.person_outline,
              label: context.strings.patient,
              value: notification.patientName!,
            ),
          if (hasPatientPhone)
            NotificationDetailInfoRow(
              icon: Icons.phone_outlined,
              label: context.strings.phoneNumber,
              value: notification.patientPhone!,
            ),
          if (hasBookingRef)
            NotificationDetailInfoRow(
              icon: Icons.tag,
              label: context.strings.bookingId,
              value: '#${notification.bookingRef}',
            ),
          if (hasBookingDate)
            NotificationDetailInfoRow(
              icon: Icons.calendar_today_outlined,
              label: context.strings.appointmentDate,
              value: _formatBookingDate(notification.bookingDate!),
            ),
          if (hasBookingTime)
            NotificationDetailInfoRow(
              icon: Icons.access_time_outlined,
              label: context.strings.appointmentTime,
              value: notification.bookingTime!,
            ),
          if (hasVisitType)
            NotificationDetailInfoRow(
              icon: Icons.medical_services_outlined,
              label: context.strings.visitType,
              value: notification.visitType!,
            ),
        ],
      ),
    );
  }
}
