import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class ResetPasswordHeader extends StatelessWidget {
  const ResetPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Image.asset(
          AppConstants.rLogo,
          width: 160.w,
          height: 90.h,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 12.h),
        Text(
          context.strings.resetPasswordTitle, // "Reset Password"
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 28.sp,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          context.strings.resetPasswordSubtitle, // "Create a new strong password for your account"
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 14.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
