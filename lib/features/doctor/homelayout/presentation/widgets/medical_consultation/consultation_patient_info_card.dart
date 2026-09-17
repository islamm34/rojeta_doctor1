import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/doctor_appointment_model.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/extensions/time_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class ConsultationPatientInfoCard extends StatelessWidget {
  final DoctorAppointmentModel appointment;

  const ConsultationPatientInfoCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF29B6F6), Color(0xFF00B0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.patientName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _getPatientDemographics(context),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Date & Time
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        TimeFormatter.formatDate(
                          appointment.appointmentDate,
                          context: context,
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 16.sp, color: Colors.white),
                      SizedBox(width: 8.w),
                      Text(
                        appointment.appointmentTime.formatTo12Hour(context),
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (appointment.notes?.isNotEmpty == true) ...[
            SizedBox(height: 12.h),

            // Notes
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.strings.notes,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    appointment.notes!,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getPatientDemographics(BuildContext context) {
    final parts = <String>[];
    if (appointment.patientAge.isNotEmpty && appointment.patientAge != 'null') {
      parts.add('${appointment.patientAge} ${context.strings.years}');
    }
    if (appointment.patientGender.isNotEmpty &&
        appointment.patientGender != 'null') {
      final gender = appointment.patientGender.toLowerCase();
      if (gender == 'male') {
        parts.add(context.strings.male);
      } else if (gender == 'female') {
        parts.add(context.strings.female);
      } else {
        parts.add(appointment.patientGender);
      }
    }
    return parts.isNotEmpty ? parts.join(' • ') : '';
  }
}
