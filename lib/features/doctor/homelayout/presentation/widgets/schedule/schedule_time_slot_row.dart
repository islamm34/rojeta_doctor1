import 'package:flutter/material.dart';
import 'package:rojeta_doctor/shared/models/time_slot_model.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'schedule_time_input_box.dart';

class ScheduleTimeSlotRow extends StatelessWidget {
  final TimeSlotModel slot;

  const ScheduleTimeSlotRow({super.key, required this.slot});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(Icons.access_time, size: 18.sp, color: Colors.grey),
          SizedBox(width: 12.w),
          Expanded(child: ScheduleTimeInputBox(time: slot.startTime)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              context.strings.to,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp),
            ),
          ),
          Expanded(child: ScheduleTimeInputBox(time: slot.endTime)),
        ],
      ),
    );
  }
}
