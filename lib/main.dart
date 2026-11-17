import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:rojeta_doctor/core/utils/firebase_messaging_service.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/presentation/bloc/homelayout_bloc.dart';
import 'package:rojeta_doctor/firebase_options.dart';

import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';
import 'core/di/injector.dart';
import 'core/local/user_hive_helper.dart';
import 'core/utils/screen_util_like.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Bloc.observer = AppBlocObserver();
  await UserHiveHelper.init(); // Initialize Hive and default user
  // Initialize dependencies
  await setupInjector();
  try {
    await injector<FirebaseMessagingService>().init();
  } catch (e) {
    debugPrint('Firebase Messaging initialization error: $e');
  }
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
  ValueListenable<Box>? _settingsListenable;

  @override
  void initState() {
    super.initState();
    _currentLocale = UserHiveHelper.getAppLanguage();
    try {
      UserHiveHelper.getBoxListenable().addListener(_onBoxChanged);
    } catch (_) {}
    try {
      _settingsListenable = UserHiveHelper.getSettingsBoxListenable();
      _settingsListenable?.addListener(_onBoxChanged);
    } catch (_) {}
  }

  @override
  void dispose() {
    try {
      UserHiveHelper.getBoxListenable().removeListener(_onBoxChanged);
    } catch (_) {}
    try {
      _settingsListenable?.removeListener(_onBoxChanged);
    } catch (_) {}
    super.dispose();
  }

  void _onBoxChanged() {
    final user = UserHiveHelper.getUser();
    final newLocale = (user?.language != null && user!.language!.isNotEmpty)
        ? user.language!
        : UserHiveHelper.getAppLanguage();
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
