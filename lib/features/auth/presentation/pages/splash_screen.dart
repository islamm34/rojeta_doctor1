// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/constants/app_constants.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/local/user_hive_helper.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/flutter_secure_storage_helper.dart';
import '../../../../core/utils/role_navigation_helper.dart';
import '../../../../core/utils/screen_util_like.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final token = await FlutterSecureStorageHelper.getToken();
    final user = UserHiveHelper.getUser();

    if (token != null &&
        token.trim().isNotEmpty &&
        user != null &&
        user.id != null) {
      RoleNavigationHelper.navigateToRoleDashboard(
        context,
        user: user,
        clearStack: false,
      );
    } else {
      context.pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context: context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          AppConstants.splashLogoPng,
          width: 400.w,
          height: 300.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
