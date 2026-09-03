import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../data/models/schedule_model.dart';
import 'day_schedule_card.dart';

class WorkingHoursSection extends StatelessWidget {
  final List<WorkingDayModel> workingDays;
  final Function(int, bool) onToggleDay;
  final Function(int) onAddSlot;
  final VoidCallback onSave;

  const WorkingHoursSection({
    super.key,
    required this.workingDays,
    required this.onToggleDay,
    required this.onAddSlot,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.workingHours,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        ...workingDays.asMap().entries.map((entry) {
          final index = entry.key;
          final day = entry.value;
          return DayScheduleCard(
            day: day,
            onToggle: (val) => onToggleDay(index, val),
            onAddSlot: () => onAddSlot(index),
          );
        }),
        SizedBox(height: 16.h),
        CustomElevatedButton(
          text: context.strings.saveWorkingHours,
          onPressed: onSave,
          backgroundColor: const Color(0xFF00B0FF),
          borderRadius: 12.r,
          height: 52.h,
          icon: Icon(Icons.save_outlined, color: Colors.white, size: 18.sp),
        ),
      ],
    );
  }
}
