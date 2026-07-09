import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class RegistrationStatusHeader extends StatelessWidget {
  const RegistrationStatusHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.check_circle,
            color: const Color(0xFF10B981), // Green color from design
            size: 48.w,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          '🎉',
          style: TextStyle(fontSize: 24.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          context.strings.yourRequestIsUnderReview,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF10B981),
            fontSize: 18.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
