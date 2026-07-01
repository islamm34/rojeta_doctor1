import 'package:flutter/material.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import 'user_type_selection_page.dart';
import 'widgets/doctor_register_form.dart';
import 'widgets/patient_register_form.dart';

class RegisterPage extends StatelessWidget {
  final UserType userType;

  const RegisterPage({
    super.key,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final strings = context.strings;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: colors.onSurface),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                strings.signUpTitle,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              8.ver,
              Text(
                strings.signUpSubtitle,
                style: textTheme.bodyLarge?.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              30.ver,
              if (userType == UserType.doctor)
                DoctorRegisterForm(
                  onSubmit: (name, email, phone, password, spec, syndicate, address, bio) {
                    // Navigate to OTP page
                    context.pushNamed(AppRoutes.otp, extra: userType);
                  },
                )
              else
                PatientRegisterForm(
                  onSubmit: (name, phone, password) {
                    // Navigate to OTP page
                    context.pushNamed(AppRoutes.otp, extra: userType);
                  },
                ),
              24.ver,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    strings.alreadyHaveAccount,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(
                      strings.loginButton,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              20.ver,
            ],
          ),
        ),
      ),
    );
  }
}
