import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/extensions/time_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/doctor_appointment_details_model.dart';

class AppointmentDetailsScheduleCard extends StatelessWidget {
  final DoctorAppointmentDetailsModel details;

  const AppointmentDetailsScheduleCard({super.key, required this.details});

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
          Text(
            context.strings.appointmentInformation,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.calendar_today_outlined,
                        size: 16.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.strings.appointmentDate,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 11.sp,
                            ),
                          ),
                          Text(
                            _formatDate(context, details.appointmentDate),
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.access_time_outlined,
                        size: 16.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.strings.appointmentTime,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 11.sp,
                            ),
                          ),
                          Text(
                            _formatTime(context, details.appointmentTime),
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.strings.serviceType,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      details.serviceType,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (details.visitType.isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.strings.visitType,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 11.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        details.visitType,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (details.address != null && details.address!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16.sp,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    details.address!,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(BuildContext context, String? rawDate) {
    return TimeFormatter.formatDate(rawDate, context: context);
  }

  String _formatTime(BuildContext context, String timeStr) {
    if (timeStr.isEmpty) return '';
    return timeStr.formatTo12Hour(context);
  }
}
