import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

import 'nursing_payout_cycle_chip.dart';

class NursingPayoutScheduleCard extends StatelessWidget {
  final bool isAutoPayout;
  final ValueChanged<bool> onAutoPayoutChanged;
  final String payoutSchedule;
  final ValueChanged<String> onScheduleChanged;

  const NursingPayoutScheduleCard({
    super.key,
    required this.isAutoPayout,
    required this.onAutoPayoutChanged,
    required this.payoutSchedule,
    required this.onScheduleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: const Color(0xFF0F2D52),
                size: 20.w,
              ),
              SizedBox(width: 8.w),
              Text(
                strings.payoutSettings,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Automatic Settlement',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      strings.payoutSettingsSubtitle,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: isAutoPayout,
                onChanged: onAutoPayoutChanged,
                activeThumbColor: const Color(0xFF2563EB),
              ),
            ],
          ),
          if (isAutoPayout) ...[
            SizedBox(height: 14.h),
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            SizedBox(height: 14.h),
            Text(
              'PAYOUT CYCLE',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF64748B),
                letterSpacing: 0.8,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                NursingPayoutCycleChip(
                  label: 'Weekly (Every Sunday)',
                  value: 'weekly',
                  isSelected: payoutSchedule == 'weekly',
                  onTap: () => onScheduleChanged('weekly'),
                ),
                SizedBox(width: 8.w),
                NursingPayoutCycleChip(
                  label: 'Monthly (1st of month)',
                  value: 'monthly',
                  isSelected: payoutSchedule == 'monthly',
                  onTap: () => onScheduleChanged('monthly'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
