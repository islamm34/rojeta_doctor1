import 'package:flutter/material.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../widgets/reset_password/reset_password_header.dart';
import '../../widgets/reset_password/reset_password_form.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context: context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            children: [
              const ResetPasswordHeader(),
              SizedBox(height: 32.h),
              const ResetPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
