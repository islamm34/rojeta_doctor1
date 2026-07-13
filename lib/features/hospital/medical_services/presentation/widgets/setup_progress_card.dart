import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../core/utils/app_colors.dart';

class SetupProgressCard extends StatelessWidget {
  final int completedSteps;
  final int totalSteps;

  const SetupProgressCard({
    super.key,
    this.completedSteps = 0,
    this.totalSteps = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
                context.strings.hospitalSetupProgress,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$completedSteps/$totalSteps',
                style: context.textTheme.titleMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          LinearProgressIndicator(
            value: completedSteps / totalSteps,
            backgroundColor: Colors.grey[200],
            color: AppColors.primary,
            minHeight: 8.h,
            borderRadius: BorderRadius.circular(4.r),
          ),
          SizedBox(height: 16.h),
          _buildStepRow(
            context,
            context.strings.addYourFirstSpecialty,
            completedSteps >= 1,
          ),
          SizedBox(height: 8.h),
          _buildStepRow(
            context,
            context.strings.addDoctorsProgress,
            completedSteps >= 2,
          ),
          SizedBox(height: 8.h),
          _buildStepRow(
            context,
            context.strings.startReceivingBookings,
            completedSteps >= 3,
          ),
        ],
      ),
    );
  }

  Widget _buildStepRow(BuildContext context, String text, bool isCompleted) {
    return Row(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? AppColors.primary : Colors.grey[400],
          size: 20.w,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: context.textTheme.bodyMedium?.copyWith(
            color: isCompleted ? Colors.black : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
