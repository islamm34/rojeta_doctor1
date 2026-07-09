import 'package:flutter/material.dart';
import '../../../../core/utils/screen_util_like.dart';
import '../widgets/login/login_header.dart';
import '../widgets/login/login_form.dart';
import '../widgets/login/login_footer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              SizedBox(height: 24.h),
              const LoginHeader(),
              SizedBox(height: 32.h),
              const LoginForm(),
              SizedBox(height: 32.h),
              const LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
