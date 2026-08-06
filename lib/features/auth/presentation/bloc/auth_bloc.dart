import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/auth/data/models/login/login_request_model.dart';
import 'package:rojeta_doctor/features/auth/data/models/otp/resend_otp_request_model.dart';
import 'package:rojeta_doctor/features/auth/data/models/otp/verify_otp_request_model.dart';
import 'package:rojeta_doctor/features/auth/data/models/register/register_request_model.dart';
import 'package:rojeta_doctor/features/auth/data/models/check_phone/check_phone_request_model.dart';
import '../../data/models/user_type_model.dart';
import '../../domain/usecases/get_auth.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/register_use_case.dart';
import '../../domain/usecases/resend_otp_use_case.dart';
import '../../domain/usecases/verify_otp_use_case.dart';
import '../../domain/usecases/check_phone_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthUseCase getAuth;
  final RegisterUseCase registerUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final LoginUseCase loginUseCase;
  final ResendOtpUseCase resendOtpUseCase;
  final CheckPhoneUseCase checkPhoneUseCase;

  AuthBloc({
    required this.getAuth,
    required this.registerUseCase,
    required this.verifyOtpUseCase,
    required this.loginUseCase,
    required this.resendOtpUseCase,
    required this.checkPhoneUseCase,
  }) : super(const AuthState()) {
    on<LoadAuthEvent>(_onLoad);
    on<SubmitRegistrationEvent>(_onSubmitRegistration);
    on<VerifyOtpSubmittedEvent>(_onVerifyOtpSubmitted);
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<ResendOtpSubmittedEvent>(_onResendOtpSubmitted);
    on<CheckPhoneSubmittedEvent>(_onCheckPhoneSubmitted);
    on<SelectUserTypeEvent>((event, emit) => emit(state.copyWith(selectedType: event.type)));
    on<FullNameChangedEvent>((event, emit) => emit(state.copyWith(fullName: event.fullName)));
    on<EmailChangedEvent>((event, emit) => emit(state.copyWith(email: event.email)));
    on<PhoneChangedEvent>((event, emit) => emit(state.copyWith(phone: event.phone, isPhoneExists: null)));
    on<PasswordChangedEvent>((event, emit) => emit(state.copyWith(password: event.password)));
    on<ConfirmPasswordChangedEvent>((event, emit) => emit(state.copyWith(confirmPassword: event.confirmPassword)));
    on<TogglePasswordVisibilityEvent>((event, emit) => emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible)));
    on<ToggleConfirmPasswordVisibilityEvent>((event, emit) => emit(state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible)));

    // Professional Information Events
    on<SpecialtyChangedEvent>((event, emit) => emit(state.copyWith(specialty: event.specialty)));
    on<SubSpecialtyChangedEvent>((event, emit) => emit(state.copyWith(subSpecialty: event.subSpecialty)));
    on<MedicalLicenseChangedEvent>((event, emit) => emit(state.copyWith(medicalLicenseNumber: event.license)));
    on<YearsOfExperienceChangedEvent>((event, emit) => emit(state.copyWith(yearsOfExperience: event.years)));
    on<EducationChangedEvent>((event, emit) => emit(state.copyWith(education: event.education)));
    on<AboutChangedEvent>((event, emit) => emit(state.copyWith(about: event.about)));

    // File Picking Events
    on<PickProfileImageEvent>((event, emit) => emit(state.copyWith(profileImagePath: event.path)));
    on<PickMedicalLicenseEvent>((event, emit) => emit(state.copyWith(medicalLicensePath: event.path)));
    on<PickCertificatesEvent>((event, emit) => emit(state.copyWith(certificatesPath: event.path)));
    on<PickNationalIdEvent>((event, emit) => emit(state.copyWith(nationalIdPath: event.path)));
    on<OtpChangedEvent>((event, emit) => emit(state.copyWith(otpCode: event.otp)));

    // Hospital Registration Events
    on<OrganizationNameChangedEvent>((event, emit) => emit(state.copyWith(organizationName: event.name)));
    on<OrganizationTypeChangedEvent>((event, emit) => emit(state.copyWith(organizationType: event.type)));
    on<OrganizationNumberChangedEvent>((event, emit) => emit(state.copyWith(organizationNumber: event.number)));
    on<PickOrganizationImageEvent>((event, emit) => emit(state.copyWith(organizationImagePath: event.path)));
    on<GovernorateChangedEvent>((event, emit) => emit(state.copyWith(governorate: event.governorate)));
    on<CityChangedEvent>((event, emit) => emit(state.copyWith(city: event.city)));
    on<FullAddressChangedEvent>((event, emit) => emit(state.copyWith(fullAddress: event.address)));
    on<PaymentMethodChangedEvent>((event, emit) => emit(state.copyWith(paymentMethod: event.method)));
    on<AccountHolderNameChangedEvent>((event, emit) => emit(state.copyWith(accountHolderName: event.name)));
    on<BankNameChangedEvent>((event, emit) => emit(state.copyWith(bankName: event.bankName)));
    on<AccountNumberChangedEvent>((event, emit) => emit(state.copyWith(accountNumber: event.number)));
    on<ExpiryDateChangedEvent>((event, emit) => emit(state.copyWith(expiryDate: event.date)));
    on<CvvChangedEvent>((event, emit) => emit(state.copyWith(cvv: event.cvv)));
  }

  FutureOr<void> _onLoad(
      LoadAuthEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await getAuth();
      emit(state.copyWith(status: AuthStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, message: e.toString()));
    }
  }

  FutureOr<void> _onSubmitRegistration(
      SubmitRegistrationEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final roleString = _getRoleString(state.selectedType);
      final names = state.fullName.trim().split(' ');
      final firstName = names.isNotEmpty ? names.first : state.fullName;
      final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

      final requestModel = RegisterRequestModel(
        userType: state.selectedType,
        role: roleString,
        name: state.fullName.isNotEmpty
            ? state.fullName
            : (state.organizationName.isNotEmpty
                ? state.organizationName
                : 'User'),
        firstName: firstName,
        lastName: lastName,
        email: state.email,
        phoneNumber: state.phone,
        password: state.password,
        passwordConfirmation:
            state.confirmPassword.isNotEmpty ? state.confirmPassword : state.password,
        governorate: state.governorate,
        city: state.city,
        area: state.city.isNotEmpty ? state.city : state.governorate,
        fullAddress: state.fullAddress,
        about: state.about,
        licenseNumber: state.medicalLicenseNumber,
        medicalLicense: state.medicalLicensePath,
        certificates:
            state.certificatesPath != null ? [state.certificatesPath!] : null,
        images: state.organizationImagePath != null
            ? [state.organizationImagePath!]
            : null,
        logo: state.profileImagePath ?? state.organizationImagePath,
        specialty: state.specialty,
        subSpecialty: state.subSpecialty,
        experienceYears: state.yearsOfExperience,
        education: state.education,
        organizationName: state.organizationName,
        organizationType: state.organizationType,
        organizationNumber: state.organizationNumber,
      );

      final response = await registerUseCase(requestModel);
      emit(state.copyWith(
        status: AuthStatus.loaded,
        message: response.message ?? 'Registration successful',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onVerifyOtpSubmitted(
      VerifyOtpSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final requestModel = VerifyOtpRequestModel(
        phone: state.phone,
        code: state.otpCode,
      );

      final response = await verifyOtpUseCase(requestModel);
      emit(state.copyWith(
        status: AuthStatus.loaded,
        message: response.message ?? 'Phone verified successfully',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onLoginSubmitted(
      LoginSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final requestModel = LoginRequestModel(
        phone: event.phone,
        password: event.password,
      );

      final response = await loginUseCase(requestModel);
      emit(state.copyWith(
        status: AuthStatus.loaded,
        message: response.message ?? 'Login successful',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onResendOtpSubmitted(
      ResendOtpSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final requestModel = ResendOtpRequestModel(
        phone: state.phone,
      );

      final response = await resendOtpUseCase(requestModel);
      emit(state.copyWith(
        status: AuthStatus.initial,
        message: response.message ?? 'OTP resent successfully',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onCheckPhoneSubmitted(
      CheckPhoneSubmittedEvent event, Emitter<AuthState> emit) async {
    final phoneToCheck = event.phone ?? state.phone;
    if (phoneToCheck.trim().isEmpty) return;

    emit(state.copyWith(status: AuthStatus.loading, isPhoneExists: null));
    try {
      final requestModel = CheckPhoneRequestModel(phone: phoneToCheck.trim());
      final response = await checkPhoneUseCase(requestModel);
      emit(state.copyWith(
        status: AuthStatus.loaded,
        isPhoneExists: response.exists,
        message: response.message ??
            (response.exists
                ? 'Phone number already registered'
                : 'Phone number available'),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        isPhoneExists: null,
        message: e.toString(),
      ));
    }
  }

  String _getRoleString(UserType? userType) {
    switch (userType) {
      case UserType.doctor:
        return 'doctor';
      case UserType.hospital:
        return 'hospital';
      case UserType.laboratory:
        return 'laboratory';
      case UserType.nursingCareProviders:
        return 'nursing';
      case UserType.radiologyCenter:
        return 'radiology';
      default:
        return 'doctor';
    }
  }
}
