import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rojeta_doctor/config/routes/app_router.dart';
import 'package:rojeta_doctor/core/di/injector.dart';
import 'package:rojeta_doctor/features/doctor/chat/data/repositories/doctor_chat_repository.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/presentation/widgets/appointment/appointment_card_action_buttons.dart';

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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                        Expanded(
                          child: Text(
                            appointment.patientPhone ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    InkWell(
                      onTap: () async {
                        final targetPatientId =
                            (appointment.patientId?.isNotEmpty ?? false)
                            ? appointment.patientId!
                            : appointment.id.toString();

                        final conversation =
                            await injector<DoctorChatRepository>()
                                .getOrCreateConversation(
                                  patientId: targetPatientId,
                                  patientName: appointment.patientName,
                                );

                        if (!context.mounted) return;

                        context.pushNamed(
                          AppRoutes.doctorChatMessages,
                          extra: conversation,
                        );
                      },
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline_rounded,
                              size: 12.sp,
                              color: Colors.blue.shade700,
                            ),
                            SizedBox(width: 4.w),
                            Flexible(
                              child: Text(
                                context.strings.messagePatient,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                  _getStatusLabel(context, appointment.status),
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
                            _getTypeLabel(context, appointment.type),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade500,
                                fontSize: 12.sp,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (appointment.location != null &&
                        appointment.location!.isNotEmpty) ...[
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          appointment.location!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 16.h),

                // Date & Time
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 16.sp,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              _formatDate(appointment.appointmentDate),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16.sp,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(width: 6.w),
                          Flexible(
                            child: Text(
                              _formatTime(appointment.appointmentTime),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Fee
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.strings.feeLabel,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: Text(
                        appointment.feeCurrent ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Action Buttons
          AppointmentCardActionButtons(
            appointment: appointment,
            onAccept: onAccept,
            onReject: onReject,
            onViewDetails: onViewDetails,
            onStartConsultation: onStartConsultation,
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    if (dateStr.isEmpty) return '';
    final parsed = DateTime.tryParse(dateStr);
    if (parsed != null) {
      return DateFormat('yyyy-MM-dd').format(parsed);
    }
    if (dateStr.contains('T')) {
      return dateStr.split('T').first;
    }
    return dateStr;
  }

  String _formatTime(String timeStr) {
    if (timeStr.isEmpty) return '';
    final parsed = DateTime.tryParse(timeStr);
    if (parsed != null) {
      return DateFormat.jm().format(parsed);
    }
    return timeStr;
  }

  IconData _getIconForType(String type) {
    if (type.toLowerCase().contains('video')) {
      return Icons.videocam_outlined;
    } else if (type.toLowerCase().contains('home')) {
      return Icons.home_outlined;
    }
    return Icons.calendar_today_outlined;
  }

  String _getStatusLabel(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return context.strings.filterConfirmed;
      case 'pending':
        return context.strings.filterPending;
      case 'completed':
        return context.strings.filterCompleted;
      case 'cancelled':
      case 'rejected':
        return context.strings.filterCancelled;
      default:
        return status;
    }
  }

  String _getTypeLabel(BuildContext context, String type) {
    final lower = type.toLowerCase();
    if (lower.contains('video') || lower.contains('online')) {
      return context.strings.videoCall;
    } else if (lower.contains('home')) {
      return context.strings.homeVisit;
    } else if (lower.contains('clinic')) {
      return context.strings.clinicVisit;
    }
    return type;
  }
}
