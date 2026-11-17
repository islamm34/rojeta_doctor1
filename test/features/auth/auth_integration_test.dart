// Integration test skeleton for the auth feature.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rojeta_doctor/core/di/injector.dart' as core_injector;
import 'package:rojeta_doctor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rojeta_doctor/features/auth/presentation/bloc/auth_state.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/doctor_registration_flow_pages/login_page.dart';
import 'package:rojeta_doctor/l10n/app_localizations.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() async {
    await core_injector.injector.reset();
    mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(const AuthState());
    when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockAuthBloc.close()).thenAnswer((_) async {});
    core_injector.injector.registerFactory<AuthBloc>(() => mockAuthBloc);
  });

  tearDown(() async {
    await core_injector.injector.reset();
  });

  testWidgets('Load auth feature end-to-end', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('en'),
        home: LoginPage(),
      ),
    );

    expect(find.byType(LoginPage), findsOneWidget);
  });
}
