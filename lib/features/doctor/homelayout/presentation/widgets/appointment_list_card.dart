import 'package:flutter/material.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../data/models/doctor_appointment_model.dart';

class AppointmentListCard extends StatelessWidget {
  final DoctorAppointmentModel appointment;
  final VoidCallback? onTap;

  const AppointmentListCard({
    super.key,
    required this.appointment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Dynamic colors based on status
    Color statusBgColor;
    Color statusTextColor;
    if (appointment.status == 'Confirmed') {
      statusBgColor = theme.colorScheme.primary.withValues(alpha: 0.1);
      statusTextColor = theme.colorScheme.primary;
    } else if (appointment.status == 'Pending') {
      statusBgColor = Colors.orange.withValues(alpha: 0.1);
      statusTextColor = Colors.orange.shade700;
    } else {
      statusBgColor = Colors.green.withValues(alpha: 0.1);
      statusTextColor = Colors.green.shade700;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade100,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                appointment.type == 'Home Visit'
                    ? Icons.home_outlined
                    : Icons.local_hospital_outlined,
                color: theme.colorScheme.primary,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.patientName,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        '${appointment.patientAge} • ${appointment.patientGender}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade500,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          appointment.type,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: theme.colorScheme.primary,
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        appointment.appointmentTime,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: statusBgColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                appointment.status,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: statusTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
