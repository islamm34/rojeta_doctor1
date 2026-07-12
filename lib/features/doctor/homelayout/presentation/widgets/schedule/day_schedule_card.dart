import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../data/models/schedule_model.dart';

class DayScheduleCard extends StatelessWidget {
  final WorkingDayModel workingDay;
  final ValueChanged<bool> onToggleActive;
  final VoidCallback onAddSlot;

  const DayScheduleCard({
    super.key,
    required this.workingDay,
    required this.onToggleActive,
    required this.onAddSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Switch(
                    value: workingDay.isActive,
                    onChanged: onToggleActive,
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.blue.withValues(alpha: 0.2),
                    inactiveThumbColor: Colors.grey.shade400,
                    inactiveTrackColor: Colors.grey.shade200,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    workingDay.dayName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              if (workingDay.isActive)
                TextButton.icon(
                  onPressed: onAddSlot,
                  icon: Icon(Icons.add, size: 16.sp, color: Colors.blue),
                  label: Text(
                    context.strings.addSlot,
                    style: TextStyle(fontSize: 13.sp, color: Colors.blue),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.withValues(alpha: 0.08),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
            ],
          ),
          // Slots List
          if (workingDay.isActive && workingDay.timeSlots.isNotEmpty) ...[
            SizedBox(height: 16.h),
            ...workingDay.timeSlots.map((slot) => _buildTimeSlotRow(context, slot)),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeSlotRow(BuildContext context, TimeSlotModel slot) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(Icons.access_time, size: 18.sp, color: Colors.grey),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildTimeInput(slot.startTime),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              context.strings.to,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp),
            ),
          ),
          Expanded(
            child: _buildTimeInput(slot.endTime),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInput(String time) {
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
