import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import 'booking_summary_stat_item.dart';

class BookingSummaryCard extends StatelessWidget {
  final int pendingCount;
  final int homeVisitsCount;

  const BookingSummaryCard({
    super.key,
    required this.pendingCount,
    required this.homeVisitsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.strings.todaySummary,
            style: context.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: BookingSummaryStatItem(
                  label: context.strings.pendingBookings,
                  count: pendingCount,
                ),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: Colors.white.withValues(alpha: 0.5),
              ),
              Expanded(
                child: BookingSummaryStatItem(
                  label: context.strings.homeVisitsCount,
                  count: homeVisitsCount,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
