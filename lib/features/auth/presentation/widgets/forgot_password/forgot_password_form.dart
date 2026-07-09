import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../../config/routes/app_router.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../../shared/widgets/custom_textfield.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
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
            // Phone Number Field
            CustomTextField(
              label: context.strings.phone, // "Phone Number"
              hintText: context.strings.phoneHint, // "01234567890"
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              prefixIcon: Icon(
                Icons.phone_outlined,
                color: theme.colorScheme.primary,
                size: 20.w,
              ),
              borderRadius: 12.r,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.strings.fieldRequired;
                }
                return null;
              },
            ),
            SizedBox(height: 24.h),

            // Send Reset Code Button
            CustomElevatedButton(
              text: context.strings.sendResetCode, // "Send Reset Code"
              icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Navigate to Verify Phone Page and pass 'forgotPassword' as argument
                  context.pushNamed(AppRoutes.verifyPhone, extra: 'forgotPassword');
                }
              },
            ),
            SizedBox(height: 24.h),

            // Remember your password? Sign In
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
                          if (context.canPop) {
                            context.pop();
                          } else {
                            context.pushReplacementNamed(AppRoutes.login);
                          }
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
