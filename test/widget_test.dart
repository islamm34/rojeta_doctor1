import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rojeta_doctor/core/di/injector.dart';
import 'package:rojeta_doctor/core/local/user_data.dart';
import 'package:rojeta_doctor/core/local/user_hive_helper.dart';
import 'package:rojeta_doctor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rojeta_doctor/features/auth/presentation/bloc/auth_state.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/presentation/bloc/homelayout_bloc.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/presentation/bloc/homelayout_state.dart';
import 'package:rojeta_doctor/main.dart';

class MockAuthBloc extends Mock implements AuthBloc {}
class MockHomelayoutBloc extends Mock implements HomelayoutBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAuthBloc mockAuthBloc;
  late MockHomelayoutBloc mockHomelayoutBloc;

  setUpAll(() async {
    final tempDir = Directory.systemTemp.createTempSync();
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserDataAdapter());
    }
    await Hive.openBox<UserData>('userBox');
    if (!Hive.isBoxOpen('appSettingsBox')) {
      await Hive.openBox('appSettingsBox');
    }
    if (UserHiveHelper.getUser() == null) {
      UserHiveHelper.saveUser(
        UserData(
          id: 1,
          name: 'Test User',
          language: 'en',
          onBoardingCompleted: false,
        ),
      );
    }
  });

  setUp(() async {
    await injector.reset();
    mockAuthBloc = MockAuthBloc();
    mockHomelayoutBloc = MockHomelayoutBloc();

    when(() => mockAuthBloc.state).thenReturn(const AuthState());
    when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockAuthBloc.close()).thenAnswer((_) async {});

    when(() => mockHomelayoutBloc.state).thenReturn(const HomelayoutState());
    when(() => mockHomelayoutBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockHomelayoutBloc.close()).thenAnswer((_) async {});

    injector.registerFactory<AuthBloc>(() => mockAuthBloc);
    injector.registerFactory<HomelayoutBloc>(() => mockHomelayoutBloc);
  });

  tearDownAll(() async {
    await injector.reset();
    await Hive.close();
  });

  testWidgets('RojetaDoctorApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RojetaDoctorApp());
    expect(find.byType(MaterialApp), findsOneWidget);

    // Settle splash timer
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
