import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class LabServiceChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const LabServiceChip({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.w, color: const Color(0xFF7A8FA6)),
          SizedBox(width: 6.w),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF0F2D52),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
