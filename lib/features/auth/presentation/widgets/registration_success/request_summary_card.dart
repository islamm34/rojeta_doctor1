import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/registration_status_model.dart';

class RequestSummaryCard extends StatelessWidget {
  const RequestSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Mock Data based on the UI
    final mockData = const RegistrationStatusModel(
      requestNumber: '#DRV137825',
      status: 'pending',
      doctorName: 'علي عبدالعزيز',
      phoneNumber: '01111111111',
      isPhoneVerified: true,
      uploadedDocuments: ['مثال', 'مثال', 'مثال'],
    );

    return Column(
      children: [
        Text(
          context.strings.requestSummary,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          context.strings.submittedDataForReview,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 16.h),
        _buildInfoCard(
          context: context,
          icon: Icons.person,
          title: context.strings.doctorName,
          value: mockData.doctorName,
          backgroundColor: const Color(0xFFE3F2FD),
          iconColor: Colors.blue,
        ),
        SizedBox(height: 12.h),
        _buildInfoCard(
          context: context,
          icon: Icons.phone,
          title: context.strings.phoneNumber,
          value: mockData.phoneNumber,
          backgroundColor: const Color(0xFFE8F5E9),
          iconColor: const Color(0xFF10B981),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified, color: const Color(0xFF10B981), size: 16.w),
              SizedBox(width: 4.w),
              Text(
                context.strings.verified,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF10B981),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        _buildDocumentsCard(context, mockData.uploadedDocuments),
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: backgroundColor.withOpacity(0.5)),
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
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      value,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (trailing != null) ...[
                      SizedBox(width: 8.w),
                      trailing,
                    ],
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: iconColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20.w),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsCard(BuildContext context, List<String> docs) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.strings.uploadedDocuments,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.purple,
                  ),
                ),
                SizedBox(height: 8.h),
                ...docs.map((doc) => Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    children: [
                      Icon(Icons.check, color: Colors.purple, size: 16.w),
                      SizedBox(width: 4.w),
                      Text(
                        doc,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
              color: Colors.purpleAccent,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.description, color: Colors.white, size: 20.w),
          ),
        ],
      ),
    );
  }
}
