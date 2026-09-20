import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/time_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class ScheduleTimeInputBox extends StatelessWidget {
  final String time;
  final VoidCallback? onTap;

  const ScheduleTimeInputBox({super.key, required this.time, this.onTap});

  @override
  Widget build(BuildContext context) {
    final displayTime = time.isEmpty ? '-- : --' : time.formatTo12Hour(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: time.isEmpty ? Colors.blue.shade200 : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              displayTime,
              style: TextStyle(
                color: time.isEmpty ? Colors.grey : Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 18.sp,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
