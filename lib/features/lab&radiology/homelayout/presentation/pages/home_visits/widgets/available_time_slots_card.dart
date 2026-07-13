import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import '../../../../data/models/home_visit_config_model.dart';

class AvailableTimeSlotsCard extends StatelessWidget {
  final List<TimeSlotModel> slots;
  final bool isWeekdaysTabActive;
  final ValueChanged<bool> onTabChanged;
  final VoidCallback onAddSlot;

  const AvailableTimeSlotsCard({
    super.key,
    required this.slots,
    required this.isWeekdaysTabActive,
    required this.onTabChanged,
    required this.onAddSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time_outlined, color: const Color(0xFF0A6C74), size: 20.r),
              SizedBox(width: 8.w),
              Text(
                'Available Time Slots',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2D52),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildTab('WEEKDAYS', isWeekdaysTabActive, () => onTabChanged(true)),
              SizedBox(width: 8.w),
              _buildTab('WEEKENDS', !isWeekdaysTabActive, () => onTabChanged(false)),
            ],
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              ...slots.map((slot) => _buildSlotCard(context, slot)),
              _buildAddSlotCard(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF45F5D0) : const Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? const Color(0xFF0F2D52) : const Color(0xFF7A8FA6),
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildSlotCard(BuildContext context, TimeSlotModel slot) {
    Color borderColor;
    Color statusBgColor;
    Color statusTextColor;
    
    switch (slot.status) {
      case TimeSlotStatus.active:
        borderColor = const Color(0xFF0F2D52);
        statusBgColor = const Color(0xFF0F2D52);
        statusTextColor = Colors.white;
        break;
      case TimeSlotStatus.ready:
        borderColor = const Color(0xFFCBD5E1);
        statusBgColor = const Color(0xFF45F5D0);
        statusTextColor = const Color(0xFF0F2D52);
        break;
      case TimeSlotStatus.disabled:
        borderColor = const Color(0xFFE2E8F0);
        statusBgColor = const Color(0xFFE2E8F0);
        statusTextColor = const Color(0xFF7A8FA6);
        break;
    }

    return Container(
      width: 72.w,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Text(
            slot.time,
            style: context.textTheme.titleMedium?.copyWith(
              color: slot.status == TimeSlotStatus.disabled ? const Color(0xFF7A8FA6) : const Color(0xFF1877F2),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            slot.amPm,
            style: context.textTheme.labelSmall?.copyWith(
              color: const Color(0xFF7A8FA6),
              fontWeight: FontWeight.bold,
              fontSize: 9.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              slot.status.name.toUpperCase(),
              style: TextStyle(
                color: statusTextColor,
                fontSize: 8.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddSlotCard(BuildContext context) {
    return GestureDetector(
      onTap: onAddSlot,
      child: Container(
        width: 72.w,
        height: 82.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFFCBD5E1), style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: const Color(0xFF0F2D52), size: 24.r),
            SizedBox(height: 4.h),
            Text(
              'NEW SLOT',
              style: context.textTheme.labelSmall?.copyWith(
                color: const Color(0xFF7A8FA6),
                fontWeight: FontWeight.bold,
                fontSize: 9.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
