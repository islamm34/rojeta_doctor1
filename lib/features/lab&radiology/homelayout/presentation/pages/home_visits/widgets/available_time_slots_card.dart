import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

import '../../../../data/models/home_visit_config_model.dart';
import 'home_visit_add_slot_card.dart';
import 'home_visit_slot_card.dart';
import 'home_visit_slot_tab.dart';

class AvailableTimeSlotsCard extends StatelessWidget {
  final List<TimeSlotModel> slots;
  final bool isWeekdaysTabActive;
  final ValueChanged<bool> onTabChanged;
  final VoidCallback? onAddSlot;
  final ValueChanged<int>? onDeleteSlot;
  final ValueChanged<int>? onToggleSlotStatus;

  const AvailableTimeSlotsCard({
    super.key,
    required this.slots,
    required this.isWeekdaysTabActive,
    required this.onTabChanged,
    this.onAddSlot,
    this.onDeleteSlot,
    this.onToggleSlotStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                color: const Color(0xFF0A6C74),
                size: 20.r,
              ),
              SizedBox(width: 8.w),
              Text(
                context.strings.availableTimeSlots,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2D52),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            context.strings.sampleExtractionRoadDesc,
            style: context.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF7A8FA6),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              HomeVisitSlotTab(
                title: context.strings.weekdays,
                isActive: isWeekdaysTabActive,
                onTap: () => onTabChanged(true),
              ),
              SizedBox(width: 8.w),
              HomeVisitSlotTab(
                title: context.strings.weekends,
                isActive: !isWeekdaysTabActive,
                onTap: () => onTabChanged(false),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              ...slots.asMap().entries.map(
                (entry) => HomeVisitSlotCard(
                  slot: entry.value,
                  onTap: () => onToggleSlotStatus?.call(entry.key),
                  onDelete: () => onDeleteSlot?.call(entry.key),
                ),
              ),
              HomeVisitAddSlotCard(onTap: onAddSlot),
            ],
          ),
        ],
      ),
    );
  }
}
