import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class RequestNumberSection extends StatelessWidget {
  const RequestNumberSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          context.strings.requestNumber,
          style: theme.textTheme.bodySmall?.copyWith(
            color: const Color(0xFF10B981),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          '#DRV137825', // Should be dynamic in reality from state
          style: theme.textTheme.headlineMedium?.copyWith(
            color: const Color(0xFF10B981),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          context.strings.keepThisNumberForTracking,
          style: theme.textTheme.bodySmall?.copyWith(
            color: const Color(0xFF10B981),
          ),
        ),
      ],
    );
  }
}
