import 'package:flutter/material.dart';
import '../../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/doctor_appointment_model.dart';

class AppointmentsTabCard extends StatelessWidget {
  final DoctorAppointmentModel appointment;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onViewDetails;
  final VoidCallback? onStartConsultation;

  const AppointmentsTabCard({
    super.key,
    required this.appointment,
    this.onAccept,
    this.onReject,
    this.onViewDetails,
    this.onStartConsultation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    // Status colors
    Color statusBgColor;
    Color statusTextColor;
    if (appointment.status.toLowerCase() == 'confirmed') {
      statusBgColor = Colors.blue.withValues(alpha: 0.15);
      statusTextColor = Colors.blue.shade700;
    } else if (appointment.status.toLowerCase() == 'pending') {
      statusBgColor = Colors.amber.withValues(alpha: 0.15);
      statusTextColor = Colors.amber.shade800;
    } else if (appointment.status.toLowerCase() == 'completed') {
      statusBgColor = Colors.green.withValues(alpha: 0.15);
      statusTextColor = Colors.green.shade700;
    } else {
      statusBgColor = Colors.red.withValues(alpha: 0.15);
      statusTextColor = Colors.red.shade700;
    }

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
          // Top Row (User info & Status)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.blue,
                    size: 24.sp,
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
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          size: 14.sp,
                          color: Colors.grey.shade500,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          appointment.patientPhone ?? '',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  appointment.status.toLowerCase(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: statusTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Middle Section (Gray box)
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                // Type & Location
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Icon(
                        _getIconForType(appointment.type),
                        color: Colors.grey.shade700,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment.type,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontSize: 14.sp,
                            ),
                          ),
                          if (appointment.notes != null &&
                              appointment.notes!.isNotEmpty)
                            Text(
                              appointment.notes!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade500,
                                fontSize: 12.sp,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (appointment.location != null &&
                        appointment.location!.isNotEmpty)
                      Text(
                        appointment.location!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                          fontSize: 12.sp,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Date & Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 16.sp, color: Colors.grey.shade600),
                        SizedBox(width: 6.w),
                        Text(
                          appointment.appointmentDate,
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16.sp, color: Colors.grey.shade600),
                        SizedBox(width: 6.w),
                        Text(
                          appointment.appointmentTime,
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Fee
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fee',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13.sp,
                      ),
                    ),
                    Text(
                      appointment.feeCurrent ?? '',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Action Buttons
          _buildActionButtons(theme),
        ],
      ),
    );
  }

  IconData _getIconForType(String type) {
    if (type.toLowerCase().contains('video')) {
      return Icons.videocam_outlined;
    } else if (type.toLowerCase().contains('home')) {
      return Icons.home_outlined;
    }
    return Icons.calendar_today_outlined;
  }

  Widget _buildActionButtons(ThemeData theme) {
    final status = appointment.status.toLowerCase();

    if (status == 'pending') {
      if (appointment.isOnline) {
        // Only Reject button for pending video call
        return SizedBox(
          width: 140.w,
          child: ElevatedButton(
            onPressed: onReject,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cancel_outlined, size: 18.sp),
                SizedBox(width: 6.w),
                Text('Reject', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
              ],
            ),
          ),
        );
      } else {
        // Accept and Reject buttons
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onAccept,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C853), // Green
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline, size: 18.sp),
                    SizedBox(width: 6.w),
                    Text('Accept', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: onReject,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cancel_outlined, size: 18.sp),
                    SizedBox(width: 6.w),
                    Text('Reject', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    } else if (status == 'completed') {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onViewDetails,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade100,
            foregroundColor: Colors.black87,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 12.h),
          ),
          child: Text('View Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
        ),
      );
    } else if (status == 'confirmed') {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onStartConsultation,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 12.h),
          ),
          child: Text('Start Consultation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
