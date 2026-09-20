import 'package:flutter/material.dart';
import 'package:rojeta_doctor/shared/models/time_slot_model.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'schedule_time_input_box.dart';

class ScheduleTimeSlotRow extends StatelessWidget {
  final TimeSlotModel slot;
  final Function(String startTime, String endTime)? onUpdate;
  final VoidCallback? onRemove;

  const ScheduleTimeSlotRow({
    super.key,
    required this.slot,
    this.onUpdate,
    this.onRemove,
  });

  TimeOfDay _parseTime(String timeStr) {
    if (timeStr.isEmpty) return const TimeOfDay(hour: 9, minute: 0);
    try {
      final parts = timeStr.split(':');
      if (parts.length >= 2) {
        return TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 9,
          minute: int.tryParse(parts[1]) ?? 0,
        );
      }
    } catch (_) {}
    return const TimeOfDay(hour: 9, minute: 0);
  }

  String _formatTime(TimeOfDay tod) {
    final h = tod.hour.toString().padLeft(2, '0');
    final m = tod.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  Future<void> _pickStartTime(BuildContext context) async {
    final current = _parseTime(slot.startTime);
    final picked = await showTimePicker(
      context: context,
      initialTime: current,
    );
    if (picked != null) {
      final newStart = _formatTime(picked);
      onUpdate?.call(newStart, slot.endTime.isEmpty ? '17:00' : slot.endTime);
    }
  }

  Future<void> _pickEndTime(BuildContext context) async {
    final current = _parseTime(slot.endTime.isEmpty ? '17:00' : slot.endTime);
    final picked = await showTimePicker(
      context: context,
      initialTime: current,
    );
    if (picked != null) {
      final newEnd = _formatTime(picked);
      onUpdate?.call(slot.startTime.isEmpty ? '09:00' : slot.startTime, newEnd);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(Icons.access_time, size: 18.sp, color: Colors.grey.shade600),
          SizedBox(width: 8.w),
          Expanded(
            child: ScheduleTimeInputBox(
              time: slot.startTime,
              onTap: () => _pickStartTime(context),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              context.strings.to,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ScheduleTimeInputBox(
              time: slot.endTime,
              onTap: () => _pickEndTime(context),
            ),
          ),
          if (onRemove != null) ...[
            SizedBox(width: 4.w),
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                size: 20.sp,
                color: Colors.red.shade400,
              ),
              onPressed: onRemove,
              tooltip: context.strings.deleteTimeSlot,
            ),
          ],
        ],
      ),
    );
  }
}
