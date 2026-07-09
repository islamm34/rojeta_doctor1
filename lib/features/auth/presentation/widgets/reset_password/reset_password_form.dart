import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../../config/routes/app_router.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../../shared/widgets/custom_textfield.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // New Password Field
            CustomTextField(
              label: context.strings.newPassword, // "New Password"
              hintText: context.strings.enterYourPasswordHint, // "Enter your password"
              controller: _newPasswordController,
              obscureText: _obscureNewPassword,
              prefixIcon: Icon(
                Icons.lock_outline,
                color: theme.colorScheme.primary,
                size: 20.w,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureNewPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey.shade500,
                  size: 20.w,
                ),
                onPressed: () {
                  setState(() {
                    _obscureNewPassword = !_obscureNewPassword;
                  });
                },
              ),
              borderRadius: 12.r,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.strings.fieldRequired;
                }
                if (value.length < 6) {
                  return context.strings.invalidPassword;
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // Confirm New Password Field
            CustomTextField(
              label: context.strings.confirmNewPassword, // "Confirm New Password"
              hintText: context.strings.enterYourPasswordHint,
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              prefixIcon: Icon(
                Icons.lock_outline,
                color: theme.colorScheme.primary,
                size: 20.w,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey.shade500,
                  size: 20.w,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              borderRadius: 12.r,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.strings.fieldRequired;
                }
                if (value != _newPasswordController.text) {
                  return "Passwords do not match"; // (TODO: add to l10n if needed)
                }
                return null;
              },
            ),
            SizedBox(height: 24.h),

            // Reset Password Button
            CustomElevatedButton(
              text: context.strings.resetPasswordButton, // "Reset Password"
              icon: const Icon(Icons.check, color: Colors.white, size: 20),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Show success snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Password reset successfully. Please login."),
                      backgroundColor: Colors.green,
                    ),
                  );
                  // Navigate back to Login and remove history
                  context.pushNamedAndRemoveUntil(AppRoutes.login);
                }
              },
            ),
            SizedBox(height: 24.h),

            // Back to Login Redirect Link
            Center(
              child: RichText(
                text: TextSpan(
                  text: '${context.strings.rememberPassword} ',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 14.sp,
                  ),
                  children: [
                    TextSpan(
                      text: context.strings.signIn, // "Sign In"
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.pushNamedAndRemoveUntil(AppRoutes.login);
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
