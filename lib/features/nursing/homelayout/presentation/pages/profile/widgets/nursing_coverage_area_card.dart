import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_profile_model.dart';

class NursingCoverageAreaCard extends StatelessWidget {
  final NursingCoverageAreaModel area;
  final ValueChanged<bool> onToggleActive;
  final VoidCallback onDelete;

  const NursingCoverageAreaCard({
    super.key,
    required this.area,
    required this.onToggleActive,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: area.isActive
              ? const Color(0xFFE2E8F0)
              : const Color(0xFFF1F5F9),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: area.isActive
                      ? const Color(0xFFE0F2FE)
                      : const Color(0xFFF1F5F9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_city_outlined,
                  color: area.isActive
                      ? const Color(0xFF0284C7)
                      : const Color(0xFF94A3B8),
                  size: 20.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      area.name.isNotEmpty ? area.name : strings.locationNotSet,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: area.isActive
                            ? const Color(0xFF0F172A)
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                    if (area.city.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(
                        area.city,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Switch.adaptive(
                value: area.isActive,
                onChanged: onToggleActive,
                activeThumbColor: const Color(0xFF2563EB),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          SizedBox(height: 12.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.radar_outlined,
                      size: 14.w,
                      color: const Color(0xFF64748B),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${area.radiusKm} km',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF475569),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (area.extraFee > 0) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_road,
                        size: 14.w,
                        color: const Color(0xFFB45309),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '+${area.extraFee.toStringAsFixed(0)} ${strings.egp}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFFB45309),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFFEF4444),
                  size: 20,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
