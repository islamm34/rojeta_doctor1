import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_auth.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthUseCase getAuth;

  AuthBloc({required this.getAuth})
      : super(const AuthState()) {
    on<LoadAuthEvent>(_onLoad);
    on<SelectUserTypeEvent>((event, emit) => emit(state.copyWith(selectedType: event.type)));
    on<FullNameChangedEvent>((event, emit) => emit(state.copyWith(fullName: event.fullName)));
    on<EmailChangedEvent>((event, emit) => emit(state.copyWith(email: event.email)));
    on<PhoneChangedEvent>((event, emit) => emit(state.copyWith(phone: event.phone)));
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
      await getAuth(); // simple version
      emit(state.copyWith(status: AuthStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, message: e.toString()));
    }
  }
}
