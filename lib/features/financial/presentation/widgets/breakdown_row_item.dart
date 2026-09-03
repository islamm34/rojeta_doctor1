import 'package:flutter/material.dart';
import '../../../../core/utils/screen_util_like.dart';

class BreakdownRowItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final Color? valueColor;
  final bool isBold;

  const BreakdownRowItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade700,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
                color: valueColor,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
