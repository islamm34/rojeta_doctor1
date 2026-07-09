import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Back to Login Button
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: InkWell(
            onTap: () {
              if (context.canPop) {
                context.pop();
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                SizedBox(width: 8.w),
                Text(
                  context.strings.backToLogin, // "Back to Login"
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 32.h),

        // Padlock Icon Container
        Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            Icons.lock,
            color: Colors.amber.shade700, // Golden padlock color
            size: 40.sp,
          ),
        ),
        SizedBox(height: 24.h),

        // Title
        Text(
          context.strings.forgotPasswordTitle, // "Forgot Password"
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 28.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),

        // Subtitle
        Text(
          context.strings.forgotPasswordSubtitle, // "Enter your phone number to reset password"
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 14.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
