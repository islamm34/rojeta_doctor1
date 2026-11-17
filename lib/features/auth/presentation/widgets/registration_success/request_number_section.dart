import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class RequestNumberSection extends StatelessWidget {
  final String requestNumber;

  const RequestNumberSection({
    super.key,
    this.requestNumber = '#DRV137825',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.strings.requestNumber,
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF10B981),
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            requestNumber,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: const Color(0xFF10B981),
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            context.strings.keepThisNumberForTracking,
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF10B981),
              fontSize: 12.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
