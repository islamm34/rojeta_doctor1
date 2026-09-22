import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'setup_step_row.dart';

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
          SetupStepRow(
            text: context.strings.addYourFirstSpecialty,
            isCompleted: completedSteps >= 1,
          ),
          SizedBox(height: 8.h),
          SetupStepRow(
            text: context.strings.addDoctorsProgress,
            isCompleted: completedSteps >= 2,
          ),
          SizedBox(height: 8.h),
          SetupStepRow(
            text: context.strings.startReceivingBookings,
            isCompleted: completedSteps >= 3,
          ),
        ],
      ),
    );
  }
}
