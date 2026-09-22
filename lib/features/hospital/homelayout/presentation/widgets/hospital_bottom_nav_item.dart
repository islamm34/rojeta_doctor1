import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class HospitalBottomNavItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final IconData icon;
  final String label;
  final ValueChanged<int> onTap;

  const HospitalBottomNavItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 3.h,
            width: 25.w,
            decoration: BoxDecoration(
              color: isSelected ? context.colors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          10.ver,
          Icon(
            icon,
            color: isSelected ? context.colors.primary : Colors.grey.shade600,
            size: 28.r,
          ),
          4.ver,
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: isSelected ? context.colors.primary : Colors.grey.shade600,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
