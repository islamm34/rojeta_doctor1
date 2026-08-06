import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/injector.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../bloc/auth_bloc.dart';
import '../../widgets/login/login_header.dart';
import '../../widgets/login/login_form.dart';
import '../../widgets/login/login_footer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context: context);
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => injector<AuthBloc>(),
      child: Scaffold(
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
      ),
    );
  }
}
