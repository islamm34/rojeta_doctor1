import 'package:flutter/material.dart';

class TransactionAmountRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const TransactionAmountRow({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
                color: isBold ? Colors.black87 : Colors.grey.shade600,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
                color: valueColor ?? Colors.black87,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
