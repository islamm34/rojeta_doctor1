import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class LabBottomNavItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final IconData icon;
  final String label;
  final ValueChanged<int> onSelected;

  const LabBottomNavItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.icon,
    required this.label,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF1877F2);
    final inactiveColor = Colors.grey.shade400;

    return GestureDetector(
      onTap: () => onSelected(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? activeColor : inactiveColor,
            size: 26.r,
          ),
          4.ver,
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
                  color: isSelected ? activeColor : inactiveColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }
}
