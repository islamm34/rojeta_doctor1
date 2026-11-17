import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class PeriodToggleButtons extends StatelessWidget {
  final String selectedPeriod;
  final ValueChanged<String>? onPeriodChanged;

  const PeriodToggleButtons({
    super.key,
    this.selectedPeriod = 'today',
    this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.strings;
    final periods = [
      {'key': 'today', 'label': strings.today},
      {'key': 'week', 'label': strings.week},
      {'key': 'month', 'label': strings.month},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: periods.map((item) {
          final isSelected = selectedPeriod.toLowerCase() == item['key'];
          return Expanded(
            child: GestureDetector(
              onTap: () {
                if (onPeriodChanged != null) {
                  onPeriodChanged!(item['key']!);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  item['label']!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
