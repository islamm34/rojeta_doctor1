import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rojeta_doctor/core/di/injector.dart' as core_injector;
import 'package:rojeta_doctor/features/auth/domain/repositories/auth_repository.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/check_phone_use_case.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/get_auth.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/login_use_case.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/logout_use_case.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/register_use_case.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:rojeta_doctor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rojeta_doctor/features/auth/presentation/bloc/auth_event.dart';
import 'package:rojeta_doctor/features/auth/presentation/bloc/auth_state.dart';
import 'package:rojeta_doctor/features/auth/presentation/widgets/hospital_registeration_flow_pages_widgets/hospital_location_form.dart';
import 'package:rojeta_doctor/features/auth/presentation/widgets/location/map_location_picker_button.dart';
import 'package:rojeta_doctor/l10n/app_localizations.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
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

  test('AuthState copyWith handles latitude, longitude, and clearLocation correctly', () {
    const initial = AuthState();
    expect(initial.latitude, isNull);
    expect(initial.longitude, isNull);

    final updated = initial.copyWith(
      latitude: 30.0444,
      longitude: 31.2357,
      mapAddress: 'Nasr City, Cairo',
    );
    expect(updated.latitude, equals(30.0444));
    expect(updated.longitude, equals(31.2357));
    expect(updated.mapAddress, equals('Nasr City, Cairo'));

    final cleared = updated.copyWith(clearLocation: true);
    expect(cleared.latitude, isNull);
    expect(cleared.longitude, isNull);
    expect(cleared.mapAddress, isNull);
  });

  test('AuthBloc LocationSelectedEvent overwrites fullAddress with newly selected location', () async {
    final mockRepo = MockAuthRepository();
    final bloc = AuthBloc(
      getAuth: GetAuthUseCase(mockRepo),
      registerUseCase: RegisterUseCase(mockRepo),
      verifyOtpUseCase: VerifyOtpUseCase(mockRepo),
      loginUseCase: LoginUseCase(mockRepo),
      resendOtpUseCase: ResendOtpUseCase(mockRepo),
      checkPhoneUseCase: CheckPhoneUseCase(mockRepo),
      logoutUseCase: LogoutUseCase(mockRepo),
    );

    // Initial state with an existing address
    bloc.emit(const AuthState(fullAddress: 'محور روكسي رمسيس'));
    expect(bloc.state.fullAddress, equals('محور روكسي رمسيس'));

    // Select a new location from map
    bloc.add(const LocationSelectedEvent(
      latitude: 30.05,
      longitude: 31.24,
      address: 'شارع طلعت حرب، وسط البلد',
    ));

    await expectLater(
      bloc.stream,
      emits(predicate<AuthState>((s) =>
          s.fullAddress == 'شارع طلعت حرب، وسط البلد' &&
          s.mapAddress == 'شارع طلعت حرب، وسط البلد' &&
          s.latitude == 30.05 &&
          s.longitude == 31.24)),
    );

    await bloc.close();
  });

  testWidgets('MapLocationPickerButton renders "+ Location" when location is not set',
      (tester) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthState());

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('ar'),
        home: Scaffold(
          body: BlocProvider<AuthBloc>.value(
            value: mockAuthBloc,
            child: const MapLocationPickerButton(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('+ Location'), findsOneWidget);
    expect(find.byIcon(Icons.add_location_alt_outlined), findsOneWidget);
  });

  testWidgets('MapLocationPickerButton renders location card when location is set',
      (tester) async {
    when(() => mockAuthBloc.state).thenReturn(
      const AuthState(
        latitude: 30.0444,
        longitude: 31.2357,
        mapAddress: 'شارع طلعت حرب، وسط البلد',
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('ar'),
        home: Scaffold(
          body: BlocProvider<AuthBloc>.value(
            value: mockAuthBloc,
            child: const MapLocationPickerButton(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('شارع طلعت حرب، وسط البلد'), findsOneWidget);
    expect(find.byIcon(Icons.edit_location_alt_outlined), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);
  });

  testWidgets('HospitalLocationForm updates fullAddress text field when location is selected',
      (tester) async {
    final stateController = StreamController<AuthState>.broadcast();
    var currentState = const AuthState();
    when(() => mockAuthBloc.state).thenAnswer((_) => currentState);
    when(() => mockAuthBloc.stream).thenAnswer((_) => stateController.stream);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('ar'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: BlocProvider<AuthBloc>.value(
              value: mockAuthBloc,
              child: const HospitalLocationForm(),
            ),
          ),
        ),
      ),
    );

    await tester.pump();

    // Emit new state with selected location
    currentState = const AuthState(
      latitude: 30.05,
      longitude: 31.24,
      mapAddress: 'شارع طلعت حرب، وسط البلد',
      fullAddress: 'شارع طلعت حرب، وسط البلد',
    );
    stateController.add(currentState);

    await tester.pump();

    // Verify text field shows the new address
    expect(find.text('شارع طلعت حرب، وسط البلد'), findsWidgets);

    await stateController.close();
  });
}
