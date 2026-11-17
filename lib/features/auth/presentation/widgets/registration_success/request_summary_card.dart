import 'package:flutter/material.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/registration_status_model.dart';

class RequestSummaryCard extends StatelessWidget {
  final RegistrationStatusModel statusModel;

  const RequestSummaryCard({super.key, required this.statusModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          context.strings.requestSummary,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        Text(
          context.strings.submittedDataForReview,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
            fontSize: 12.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        _buildInfoCard(
          context: context,
          icon: Icons.person,
          title: context.strings.doctorName,
          value: statusModel.doctorName,
          backgroundColor: const Color(0xFFEFF6FF),
          iconColor: const Color(0xFF3B82F6),
        ),
        SizedBox(height: 12.h),
        _buildInfoCard(
          context: context,
          icon: Icons.phone,
          title: context.strings.phoneNumber,
          value: statusModel.phoneNumber,
          backgroundColor: const Color(0xFFF0FDF4),
          iconColor: const Color(0xFF10B981),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF10B981),
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                context.strings.verified,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF10B981),
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        _buildDocumentsCard(context, statusModel.uploadedDocuments),
      ],
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required Color backgroundColor,
    required Color iconColor,
    Widget? trailing,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: iconColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: Colors.black87,
                  ),
                ),
                if (trailing != null) ...[
                  SizedBox(height: 4.h),
                  trailing,
                ],
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 20.w),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsCard(BuildContext context, List<String> docs) {
    final effectiveDocs = docs.isNotEmpty ? docs : const ['مثال', 'مثال', 'مثال'];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.strings.uploadedDocuments,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF8B5CF6),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                ...effectiveDocs.map(
                  (doc) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: const Color(0xFF8B5CF6),
                          size: 16.w,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          doc,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF6B21A8),
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
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
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
              color: Color(0xFF8B5CF6),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.description, color: Colors.white, size: 20.w),
          ),
        ],
      ),
    );
  }
}
