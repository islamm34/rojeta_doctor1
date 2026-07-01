import 'package:flutter/material.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import 'user_type_selection_page.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginPage extends StatelessWidget {
  final UserType userType;

  const LoginPage({
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
              const LoginHeader(),
              40.ver,
              LoginForm(
                userType: userType,
                onSubmit: (emailOrPhone, password) {
                  // For demo, go to home layout or OTP
                  if (userType == UserType.doctor) {
                    context.pushNamed(AppRoutes.otp, extra: userType);
                  } else {
                    context.pushNamed(AppRoutes.home);
                  }
                },
              ),
              24.ver,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    strings.dontHaveAccount,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(
                        AppRoutes.register,
                        extra: userType,
                      );
                    },
                    child: Text(
                      strings.registerNow,
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
