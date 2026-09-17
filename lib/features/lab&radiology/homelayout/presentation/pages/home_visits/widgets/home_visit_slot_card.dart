import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/extensions/time_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

import '../../../../data/models/home_visit_config_model.dart';

class HomeVisitSlotCard extends StatelessWidget {
  final TimeSlotModel slot;

  const HomeVisitSlotCard({super.key, required this.slot});

  @override
  Widget build(BuildContext context) {
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

    final formatted = slot.time.formatTo12Hour(context);
    final parts = formatted.split(' ');
    final displayTime = parts.isNotEmpty ? parts[0] : slot.time;
    final displayAmPm = parts.length > 1
        ? '${parts[1]} SLOT'
        : (slot.amPm.isNotEmpty ? slot.amPm : '');

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
            displayTime,
            style: context.textTheme.titleMedium?.copyWith(
              color: slot.status == TimeSlotStatus.disabled
                  ? const Color(0xFF7A8FA6)
                  : const Color(0xFF1877F2),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            displayAmPm,
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
}
