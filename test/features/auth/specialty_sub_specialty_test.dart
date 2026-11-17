import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rojeta_doctor/features/auth/data/models/doctor_specialty.dart';
import 'package:rojeta_doctor/features/auth/data/models/egypt_location.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/check_phone_use_case.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/get_auth.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/login_use_case.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/logout_use_case.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/register_use_case.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:rojeta_doctor/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:rojeta_doctor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rojeta_doctor/features/auth/presentation/bloc/auth_event.dart';

class MockGetAuth extends Mock implements GetAuthUseCase {}
class MockRegister extends Mock implements RegisterUseCase {}
class MockVerifyOtp extends Mock implements VerifyOtpUseCase {}
class MockLogin extends Mock implements LoginUseCase {}
class MockResendOtp extends Mock implements ResendOtpUseCase {}
class MockCheckPhone extends Mock implements CheckPhoneUseCase {}
class MockLogout extends Mock implements LogoutUseCase {}

void main() {
  group('DoctorSubSpecialty & DoctorSpecialty', () {
    test('every specialty has subSpecialties defined', () {
      for (final specialty in DoctorSpecialty.values) {
        expect(specialty.subSpecialties, isNotEmpty);
      }
    });

    test('cardiology subSpecialties contain cardiology specific fields', () {
      final cardioSubs = DoctorSpecialty.cardiology.subSpecialties;

      expect(cardioSubs, contains(DoctorSubSpecialty.cardioInterventional));
      expect(
        cardioSubs,
        contains(DoctorSubSpecialty.cardioCardiothoracicSurgery),
      );
      expect(cardioSubs, contains(DoctorSubSpecialty.cardioPediatric));
    });

    test('DoctorSubSpecialty.fromString matches by value or name', () {
      final fromValue = DoctorSubSpecialty.fromString(
        'cardio_interventional',
        specialty: DoctorSpecialty.cardiology,
      );
      expect(fromValue, equals(DoctorSubSpecialty.cardioInterventional));
      expect(fromValue?.value, 'cardio_interventional');

      final fromName = DoctorSubSpecialty.fromString(
        'cardioInterventional',
        specialty: DoctorSpecialty.cardiology,
      );
      expect(fromName, equals(DoctorSubSpecialty.cardioInterventional));
    });
  });

  group('EgyptGovernorate & EgyptCity', () {
    test('every governorate has cities defined', () {
      for (final gov in EgyptGovernorate.values) {
        expect(gov.cities, isNotEmpty);
      }
    });

    test('cairo cities contain nasr_city and heliopolis', () {
      final cairoCities = EgyptGovernorate.cairo.cities;
      expect(cairoCities, contains(EgyptCity.cairoNasrCity));
      expect(cairoCities, contains(EgyptCity.cairoHeliopolis));
      expect(cairoCities, contains(EgyptCity.cairoMaadi));
    });

    test('EgyptGovernorate & EgyptCity fromString resolution', () {
      final gov = EgyptGovernorate.fromString('cairo');
      expect(gov, equals(EgyptGovernorate.cairo));

      final city = EgyptCity.fromString(
        'cairo_nasr_city',
        governorate: EgyptGovernorate.cairo,
      );
      expect(city, equals(EgyptCity.cairoNasrCity));
    });
  });

  group('AuthBloc specialty, subSpecialty, and location linkage', () {
    late AuthBloc authBloc;

    setUp(() {
      authBloc = AuthBloc(
        getAuth: MockGetAuth(),
        registerUseCase: MockRegister(),
        verifyOtpUseCase: MockVerifyOtp(),
        loginUseCase: MockLogin(),
        resendOtpUseCase: MockResendOtp(),
        checkPhoneUseCase: MockCheckPhone(),
        logoutUseCase: MockLogout(),
      );
    });

    tearDown(() {
      authBloc.close();
    });

    test('changing specialty resets subSpecialty', () async {
      // 1. Select cardiology
      authBloc.add(SpecialtyChangedEvent(DoctorSpecialty.cardiology.value));
      await Future.delayed(const Duration(milliseconds: 20));
      expect(authBloc.state.specialty, DoctorSpecialty.cardiology.value);

      // 2. Select a sub-specialty
      authBloc.add(
        SubSpecialtyChangedEvent(DoctorSubSpecialty.cardioInterventional.value),
      );
      await Future.delayed(const Duration(milliseconds: 20));
      expect(
        authBloc.state.subSpecialty,
        DoctorSubSpecialty.cardioInterventional.value,
      );

      // 3. Change specialty to pediatrics -> subSpecialty should reset to empty
      authBloc.add(SpecialtyChangedEvent(DoctorSpecialty.pediatrics.value));
      await Future.delayed(const Duration(milliseconds: 20));
      expect(authBloc.state.specialty, DoctorSpecialty.pediatrics.value);
      expect(authBloc.state.subSpecialty, isEmpty);
    });

    test('changing governorate resets city', () async {
      // 1. Select cairo
      authBloc.add(GovernorateChangedEvent(EgyptGovernorate.cairo.value));
      await Future.delayed(const Duration(milliseconds: 20));
      expect(authBloc.state.governorate, EgyptGovernorate.cairo.value);

      // 2. Select nasr city
      authBloc.add(CityChangedEvent(EgyptCity.cairoNasrCity.value));
      await Future.delayed(const Duration(milliseconds: 20));
      expect(authBloc.state.city, EgyptCity.cairoNasrCity.value);

      // 3. Change governorate to alexandria -> city resets to empty
      authBloc.add(GovernorateChangedEvent(EgyptGovernorate.alexandria.value));
      await Future.delayed(const Duration(milliseconds: 20));
      expect(authBloc.state.governorate, EgyptGovernorate.alexandria.value);
      expect(authBloc.state.city, isEmpty);
    });
  });
}
