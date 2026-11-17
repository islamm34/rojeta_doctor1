import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class ContactUsSection extends StatelessWidget {
  const ContactUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.contactUs,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF10B981),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 12.h),
        _buildContactRow(context, context.strings.customerService, '19123'),
        SizedBox(height: 6.h),
        _buildContactRow(
          context,
          context.strings.emailLabel,
          'drivers@helalfresh.com',
        ),
        SizedBox(height: 6.h),
        _buildContactRow(
          context,
          context.strings.workingHours,
          context.strings.workingHoursDesc,
        ),
      ],
    );
  }

  Widget _buildContactRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(0xFF10B981),
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(0xFF10B981),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
