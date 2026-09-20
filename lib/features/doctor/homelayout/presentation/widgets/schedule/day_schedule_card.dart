import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/schedule_model.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'schedule_time_slot_row.dart';

class DayScheduleCard extends StatelessWidget {
  final WorkingDayModel day;
  final ValueChanged<bool> onToggle;
  final VoidCallback onAddSlot;
  final Function(int slotIndex, String startTime, String endTime)? onUpdateSlot;
  final Function(int slotIndex)? onRemoveSlot;

  const DayScheduleCard({
    super.key,
    required this.day,
    required this.onToggle,
    required this.onAddSlot,
    this.onUpdateSlot,
    this.onRemoveSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: day.isActive ? Colors.blue.shade200 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day.dayName,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: day.isActive ? Colors.black87 : Colors.grey,
                ),
              ),
              Switch(
                value: day.isActive,
                onChanged: onToggle,
                activeColor: Colors.blue,
              ),
            ],
          ),
          if (day.isActive) ...[
            SizedBox(height: 12.h),
            ...day.timeSlots.asMap().entries.map((entry) {
              final slotIndex = entry.key;
              final slot = entry.value;
              return ScheduleTimeSlotRow(
                slot: slot,
                onUpdate: (start, end) =>
                    onUpdateSlot?.call(slotIndex, start, end),
                onRemove: () => onRemoveSlot?.call(slotIndex),
              );
            }),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: onAddSlot,
                icon: const Icon(Icons.add, size: 16, color: Colors.blue),
                label: Text(
                  context.strings.addTimeSlot,
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
