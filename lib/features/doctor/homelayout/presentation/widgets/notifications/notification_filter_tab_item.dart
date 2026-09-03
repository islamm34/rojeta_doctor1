import 'package:flutter/material.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class NotificationFilterTabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isUrgent;

  const NotificationFilterTabItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.isUrgent = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? Colors.white
                        : (isUrgent ? Colors.red : Colors.grey.shade600),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
