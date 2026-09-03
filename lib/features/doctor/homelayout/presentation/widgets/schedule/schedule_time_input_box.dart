import 'package:flutter/material.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class ScheduleTimeInputBox extends StatelessWidget {
  final String time;

  const ScheduleTimeInputBox({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        time.isEmpty ? '-- : --' : time,
        style: TextStyle(
          color: time.isEmpty ? Colors.grey : Colors.black87,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
