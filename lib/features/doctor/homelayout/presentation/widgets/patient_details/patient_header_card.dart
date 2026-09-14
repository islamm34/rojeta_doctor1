import 'package:flutter/material.dart';
import 'package:rojeta_doctor/config/routes/app_router.dart';
import 'package:rojeta_doctor/core/di/injector.dart';
import 'package:rojeta_doctor/features/doctor/chat/data/repositories/doctor_chat_repository.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/patient_details_model.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'patient_header_info_box.dart';

class PatientHeaderCard extends StatelessWidget {
  final PatientModel basicInfo;

  const PatientHeaderCard({super.key, required this.basicInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2196F3).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                child: Icon(Icons.person, color: Colors.white, size: 36.r),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      basicInfo.name,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.white70, size: 14.r),
                        SizedBox(width: 4.w),
                        Text(
                          basicInfo.phone,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    if (basicInfo.address != null &&
                        basicInfo.address!.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white70,
                            size: 14.r,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            basicInfo.address!,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () async {
                        final conversation =
                            await injector<DoctorChatRepository>()
                                .getOrCreateConversation(
                                  patientId: basicInfo.id,
                                  patientName: basicInfo.name,
                                );

                        if (!context.mounted) return;

                        context.pushNamed(
                          AppRoutes.doctorChatMessages,
                          extra: conversation,
                        );
                      },
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline_rounded,
                              color: Colors.white,
                              size: 14.r,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              context.strings.messagePatient,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: PatientHeaderInfoBox(
                  title: context.strings.age,
                  value: '${basicInfo.age} ${context.strings.years}',
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: PatientHeaderInfoBox(
                  title: context.strings.gender,
                  value: basicInfo.gender,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: PatientHeaderInfoBox(
                  title: context.strings.bloodGroup,
                  value: basicInfo.bloodGroup ?? '-',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
