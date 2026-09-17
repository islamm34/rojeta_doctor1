import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class ScheduleTimeChip extends StatelessWidget {
  final String time;

  const ScheduleTimeChip({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
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
