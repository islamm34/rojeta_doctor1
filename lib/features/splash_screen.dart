// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../config/routes/app_router.dart';
import '../core/local/user_hive_helper.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/extensions/context_extensions.dart';
import '../core/utils/flutter_secure_storage_helper.dart';
import '../core/utils/screen_util_like.dart';

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
    await Future.delayed(const Duration(seconds: 0));
    if (mounted) {
      if (UserHiveHelper.getUser()?.onBoardingCompleted == true) {
        if (await FlutterSecureStorageHelper.getToken() != null) {
          context.pushReplacementNamed(AppRoutes.home);
        } else {
          context.pushReplacementNamed(AppRoutes.userTypeSelection);
        }
      } else {
        context.pushReplacementNamed(AppRoutes.userTypeSelection);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context: context);
    return Scaffold(backgroundColor: Colors.white);
  }
}
