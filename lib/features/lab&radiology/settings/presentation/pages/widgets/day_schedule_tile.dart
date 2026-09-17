import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/working_hours_model.dart';
import '../../bloc/settings_bloc.dart';
import '../../bloc/settings_event.dart';
import 'schedule_time_chip.dart';

class DayScheduleTile extends StatelessWidget {
  final DayScheduleModel day;

  const DayScheduleTile({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final isClosed = day.isClosed ?? false;
    final dayName = day.dayName ?? '';
    final openingTime = day.openingTime ?? '';
    final closingTime = day.closingTime ?? '';

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 60.w,
            child: Text(
              dayName,
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F2D52),
              ),
            ),
          ),
          if (isClosed)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'Closed',
                style: context.textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            Row(
              children: [
                ScheduleTimeChip(time: openingTime),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text('-', style: context.textTheme.bodyMedium),
                ),
                ScheduleTimeChip(time: closingTime),
              ],
            ),
          SizedBox(
            width: 20.w,
            child: Switch(
              value: !isClosed,
              onChanged: (val) {
                context.read<SettingsBloc>().add(
                  UpdateDayScheduleEvent(
                    dayName: dayName,
                    isClosed: !val,
                    openingTime: openingTime,
                    closingTime: closingTime,
                  ),
                );
              },
              activeColor: const Color(0xFF0F766E),
            ),
          ),
        ],
      ),
    );
  }
}
