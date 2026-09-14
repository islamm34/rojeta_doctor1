import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/doctor/chat/data/repositories/doctor_chat_repository.dart';

import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/di/injector.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/doctor_appointment_details_model.dart';

class AppointmentDetailsHeaderCard extends StatelessWidget {
  final DoctorAppointmentDetailsModel details;

  const AppointmentDetailsHeaderCard({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final patient = details.patient;
    final patientName = patient?.name ?? '';
    final patientPhone = patient?.phone ?? '';
    final patientAge = patient?.age?.toString() ?? '';
    final patientGender = patient?.gender ?? '';

    Color statusBgColor = Colors.grey.shade100;
    Color statusTextColor = Colors.grey.shade700;
    final statusLower = details.status.toLowerCase();

    if (statusLower == 'confirmed') {
      statusBgColor = Colors.green.shade50;
      statusTextColor = Colors.green.shade700;
    } else if (statusLower == 'completed') {
      statusBgColor = Colors.blue.shade50;
      statusTextColor = Colors.blue.shade700;
    } else if (statusLower == 'pending') {
      statusBgColor = Colors.orange.shade50;
      statusTextColor = Colors.orange.shade800;
    } else if (statusLower == 'cancelled' || statusLower == 'rejected') {
      statusBgColor = Colors.red.shade50;
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52.w,
                height: 52.h,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.blue.shade700,
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
                      patientName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 16.sp,
                      ),
                    ),
                    if (patientPhone.isNotEmpty) ...[
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
                              patientPhone,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (patientAge.isNotEmpty || patientGender.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        [
                          if (patientAge.isNotEmpty)
                            '$patientAge ${context.strings.years}',
                          if (patientGender.isNotEmpty) patientGender,
                        ].join(' • '),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      details.status,
                      style: TextStyle(
                        color: statusTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  if (details.bookingId != null &&
                      details.bookingId!.isNotEmpty) ...[
                    SizedBox(height: 6.h),
                    Text(
                      '#${details.bookingId}',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          SizedBox(height: 14.h),
          InkWell(
            onTap: () async {
              final targetPatientId = (details.patientId?.isNotEmpty ?? false)
                  ? details.patientId!
                  : details.id;

              final conversation = await injector<DoctorChatRepository>()
                  .getOrCreateConversation(
                    patientId: targetPatientId,
                    patientName: patientName,
                  );

              if (!context.mounted) return;

              context.pushNamed(
                AppRoutes.doctorChatMessages,
                extra: conversation,
              );
            },
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 16.sp,
                    color: Colors.blue.shade700,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    context.strings.messagePatient,
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
