import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/data/models/working_hours_model.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/presentation/bloc/settings_bloc.dart';
import 'package:rojeta_doctor/features/lab&radiology/settings/presentation/bloc/settings_event.dart';

class DayScheduleTile extends StatelessWidget {
  final DayScheduleModel day;

  const DayScheduleTile({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
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
              day.dayName,
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F2D52),
              ),
            ),
          ),
          if (day.isClosed)
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
                _buildTimeChip(context, day.openingTime),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text('-', style: context.textTheme.bodyMedium),
                ),
                _buildTimeChip(context, day.closingTime),
              ],
            ),
          SizedBox(
            width: 20.w,
            child: Switch(
              value: !day.isClosed,
              onChanged: (val) {
                context.read<SettingsBloc>().add(
                  UpdateDayScheduleEvent(
                    dayName: day.dayName,
                    isClosed: !val,
                    openingTime: day.openingTime,
                    closingTime: day.closingTime,
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

  Widget _buildTimeChip(BuildContext context, String time) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        time,
        style: context.textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF0F2D52),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
