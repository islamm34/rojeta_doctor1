import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/patient_model.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../config/routes/app_router.dart';
import 'patient_info_column.dart';

class PatientListCard extends StatelessWidget {
  final PatientModel patient;

  const PatientListCard({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.patientDetails, extra: patient.id);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
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
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: const Color(0xFFE3F2FD),
                  child: Icon(
                    Icons.person,
                    color: const Color(0xFF2196F3),
                    size: 28.r,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.name,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 14.r, color: Colors.grey),
                          SizedBox(width: 4.w),
                          Text(
                            patient.phone,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: PatientInfoColumn(
                    title: context.strings.age,
                    value: '${patient.age} ${context.strings.years}',
                  ),
                ),
                Expanded(
                  child: PatientInfoColumn(
                    title: context.strings.gender,
                    value: patient.gender,
                  ),
                ),
                Expanded(
                  child: PatientInfoColumn(
                    title: context.strings.visits,
                    value: '${patient.visitsCount}',
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            const Divider(height: 1),
            SizedBox(height: 12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.history,
                  size: 16.sp,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${context.strings.lastVisit}: ${patient.lastVisitDate}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        patient.lastDiagnosis,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
