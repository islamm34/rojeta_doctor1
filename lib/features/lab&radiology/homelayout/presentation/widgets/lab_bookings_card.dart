import 'package:flutter/material.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class LabBookingsCard extends StatelessWidget {
  final int? count;
  final String? progress;

  const LabBookingsCard({super.key, this.count, this.progress});

  @override
  Widget build(BuildContext context) {
    final displayCount = (count ?? 0).toString();
    final displayProgress = progress ?? '';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.strings.todaysBookings.toUpperCase(),
                  style: context.textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF7A8FA6),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      displayCount,
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: const Color(0xFF0F2D52),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (displayProgress.isNotEmpty) ...[
                      SizedBox(width: 8.w),
                      Text(
                        displayProgress,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF00B050),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F5FA),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: Color(0xFF1877F2),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
