import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/doctor_appointment_details_model.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class AppointmentDetailsConsultationCard extends StatelessWidget {
  final AppointmentConsultationModel consultation;

  const AppointmentDetailsConsultationCard({
    super.key,
    required this.consultation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_services_outlined,
                size: 18.sp,
                color: Colors.teal.shade700,
              ),
              SizedBox(width: 8.w),
              Text(
                context.strings.consultationDetails,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          if (consultation.diagnosis != null &&
              consultation.diagnosis!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              context.strings.diagnosis,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              consultation.diagnosis!,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          if (consultation.medicationDetails != null &&
              consultation.medicationDetails!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              context.strings.prescription,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              consultation.medicationDetails!,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
          ],
          if (consultation.laboratoryTests != null &&
              consultation.laboratoryTests!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              context.strings.laboratoryTests,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              consultation.laboratoryTests!,
              style: TextStyle(color: Colors.black87, fontSize: 13.sp),
            ),
          ],
          if (consultation.radiologyTests != null &&
              consultation.radiologyTests!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              context.strings.radiologyTests,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              consultation.radiologyTests!,
              style: TextStyle(color: Colors.black87, fontSize: 13.sp),
            ),
          ],
          if (consultation.followUpDate != null &&
              consultation.followUpDate!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Text(
                  '${context.strings.followUpDate}: ',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  _formatDate(consultation.followUpDate),
                  style: TextStyle(
                    color: Colors.teal.shade700,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(String? rawDate) {
    if (rawDate == null || rawDate.trim().isEmpty) return '';
    final trimmed = rawDate.trim();

    final parsed = DateTime.tryParse(trimmed);
    if (parsed != null) {
      final day = parsed.day.toString().padLeft(2, '0');
      final month = parsed.month.toString().padLeft(2, '0');
      final year = parsed.year.toString().padLeft(4, '0');
      return '$day/$month/$year';
    }

    final dateOnly = trimmed.split('T').first.split(' ').first;
    final parts = dateOnly.split(RegExp(r'[-/]'));
    if (parts.length == 3) {
      if (parts[0].length == 4) {
        final y = parts[0];
        final m = parts[1].padLeft(2, '0');
        final d = parts[2].padLeft(2, '0');
        return '$d/$m/$y';
      } else if (parts[2].length == 4) {
        final d = parts[0].padLeft(2, '0');
        final m = parts[1].padLeft(2, '0');
        final y = parts[2];
        return '$d/$m/$y';
      }
    }

    return dateOnly;
  }
}
