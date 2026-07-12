import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class NextStepsCard extends StatelessWidget {
  const NextStepsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F8FF), // Very light blue
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: theme.colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              Text(
                context.strings.whatHappensNext,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildStep(context, '1.', context.strings.nextStep1),
          SizedBox(height: 12.h),
          _buildStep(context, '2.', context.strings.nextStep2),
          SizedBox(height: 12.h),
          _buildStep(context, '3.', context.strings.nextStep3),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, String number, String text) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
