import 'package:flutter/material.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/extensions/time_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../data/models/lab_upcoming_booking_model.dart';

class LabUpcomingBookingCard extends StatelessWidget {
  final LabUpcomingBookingModel booking;
  final VoidCallback onTap;

  const LabUpcomingBookingCard({
    super.key,
    required this.booking,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Parse date for layout, e.g. "MAY 24" -> "MAY" and "24"
    final dateStr = booking.appointmentDate ?? '';
    final dateParts = dateStr.trim().split(RegExp(r'\s+'));
    final month = dateParts.isNotEmpty ? dateParts[0] : '';
    final day = dateParts.length > 1 ? dateParts[1] : '';

    final patientName = booking.patientName ?? '';
    final testCategory = booking.testCategory ?? '';
    final appointmentTime = (booking.appointmentTime ?? '').isNotEmpty
        ? booking.appointmentTime!.formatTo12Hour(context)
        : '';

    final subtitle = [
      if (testCategory.isNotEmpty) testCategory,
      if (appointmentTime.isNotEmpty) appointmentTime,
    ].join(' • ');

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFFEBF3FF),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  month,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF1877F2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  day,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF1877F2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF0F2D52),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF7A8FA6),
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF1F5F9),
              shape: const CircleBorder(),
            ),
            icon: const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF0F2D52),
            ),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
