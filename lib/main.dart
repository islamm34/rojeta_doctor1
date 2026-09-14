import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/presentation/bloc/homelayout_bloc.dart';

import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';
import 'core/di/injector.dart';
import 'core/local/user_hive_helper.dart';
import 'core/utils/screen_util_like.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = AppBlocObserver();
  await UserHiveHelper.init(); // Initialize Hive and default user
  // Initialize dependencies
  await setupInjector();
  runApp(const RojetaDoctorApp());
}

class RojetaDoctorApp extends StatefulWidget {
  // Static navigator key
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const RojetaDoctorApp({super.key});

  @override
  State<RojetaDoctorApp> createState() => _RojetaDoctorAppState();
}

class _RojetaDoctorAppState extends State<RojetaDoctorApp> {
  late String _currentLocale;

  @override
  void initState() {
    super.initState();
    _currentLocale = UserHiveHelper.getUser()?.language ?? 'ar';
    UserHiveHelper.getBoxListenable().addListener(_onBoxChanged);
  }

  @override
  void dispose() {
    UserHiveHelper.getBoxListenable().removeListener(_onBoxChanged);
    super.dispose();
  }

  void _onBoxChanged() {
    final newLocale = UserHiveHelper.getUser()?.language ?? 'ar';
    if (newLocale != _currentLocale) {
      setState(() {
        _currentLocale = newLocale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injector<AuthBloc>()),
        BlocProvider(create: (_) => injector<HomelayoutBloc>()),
        // BlocProvider(create: (_) => injector<ProfileBloc>()),
        // BlocProvider(create: (_) => injector<BookingBloc>()),
        // BlocProvider(create: (_) => injector<ChatBloc>()),
        // Add other global BLoCs here
      ],
      child: SafeArea(
        top: false,
        child: MaterialApp(
          navigatorKey: RojetaDoctorApp.navigatorKey, // Assign the key
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          initialRoute: AppRoutes.splash,
          locale: Locale(_currentLocale),
          themeMode: ThemeMode.light, // Or control this with a BLoC
          onGenerateRoute: AppRouter.onGenerateRoute,
          builder: (context, child) {
            if (child != null) {
              ScreenUtil.init(context: context);
            }
            return child!;
          },
        ),
      ),
    );
  }
}
