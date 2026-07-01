import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/user_type_selection_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/homelayout/presentation/pages/homelayout.dart';
import '../../features/splash_screen.dart';
import 'custom_routes.dart';

class AppRoutes {
  static const String splash = '/';
  static const String userTypeSelection = '/user-type-selection';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String home = '/home';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.userTypeSelection:
        return RightRouting(const UserTypeSelectionPage());
      case AppRoutes.login:
        final userType = settings.arguments as UserType? ?? UserType.patient;
        return RightRouting(LoginPage(userType: userType));
      case AppRoutes.register:
        final userType = settings.arguments as UserType? ?? UserType.patient;
        return RightRouting(RegisterPage(userType: userType));
      case AppRoutes.otp:
        final userType = settings.arguments as UserType? ?? UserType.patient;
        return RightRouting(OtpVerificationPage(userType: userType));
      case AppRoutes.home:
        return RightRouting(const HomeLayoutPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
