import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/visit_model.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class VisitHistorySection extends StatelessWidget {
  final List<VisitModel> visits;

  const VisitHistorySection({super.key, required this.visits});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.visitHistory,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visits.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _VisitCard(visit: visits[index]),
            );
          },
        ),
      ],
    );
  }
}

class _VisitCard extends StatelessWidget {
  final VisitModel visit;

  const _VisitCard({super.key, required this.visit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16.r, color: Colors.blue),
                  SizedBox(width: 8.w),
                  Text(
                    DateFormat('yyyy-MM-dd').format(visit.date),
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: visit.type == 'Follow-up' ? const Color(0xFFE3F2FD) : const Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  visit.type,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: visit.type == 'Follow-up' ? Colors.blue[700] : Colors.indigo[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildDetailRow(context, Icons.description_outlined, context.strings.diagnosis, visit.diagnosis),
          SizedBox(height: 12.h),
          _buildDetailRow(context, Icons.medication_outlined, context.strings.prescription, visit.prescription),
          SizedBox(height: 12.h),
          _buildDetailRow(context, Icons.note_alt_outlined, context.strings.notes, visit.notes),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                context.strings.followUpDate,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                DateFormat('yyyy-MM-dd').format(visit.followUpDate),
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16.r, color: Colors.grey[600]),
            SizedBox(width: 8.w),
            Text(
              title,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: Text(
            content,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
