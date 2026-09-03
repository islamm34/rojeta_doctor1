import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/patient_details_model.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'visit_detail_row.dart';

class VisitHistorySection extends StatelessWidget {
  final List<VisitModel> visitHistory;

  const VisitHistorySection({super.key, required this.visitHistory});

  @override
  Widget build(BuildContext context) {
    if (visitHistory.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.visitHistory,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visitHistory.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final visit = visitHistory[index];
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey[200]!),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('yyyy-MM-dd').format(visit.date),
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          visit.type,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF1976D2),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  VisitDetailRow(
                    icon: Icons.assignment_outlined,
                    title: context.strings.diagnosis,
                    content: visit.diagnosis,
                  ),
                  if (visit.prescription.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    VisitDetailRow(
                      icon: Icons.medication_outlined,
                      title: context.strings.prescription,
                      content: visit.prescription,
                    ),
                  ],
                  if (visit.notes.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    VisitDetailRow(
                      icon: Icons.notes_outlined,
                      title: context.strings.medicalNotes,
                      content: visit.notes,
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
