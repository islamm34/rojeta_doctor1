import 'package:equatable/equatable.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoadAuthEvent extends AuthEvent {}

class SelectUserTypeEvent extends AuthEvent {
  final UserType type;
  const SelectUserTypeEvent(this.type);
  @override
  List<Object?> get props => [type];
}

class FullNameChangedEvent extends AuthEvent {
  final String fullName;
  const FullNameChangedEvent(this.fullName);
  @override
  List<Object?> get props => [fullName];
}

class EmailChangedEvent extends AuthEvent {
  final String email;
  const EmailChangedEvent(this.email);
  @override
  List<Object?> get props => [email];
}

class PhoneChangedEvent extends AuthEvent {
  final String phone;
  const PhoneChangedEvent(this.phone);
  @override
  List<Object?> get props => [phone];
}

class PasswordChangedEvent extends AuthEvent {
  final String password;
  const PasswordChangedEvent(this.password);
  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChangedEvent extends AuthEvent {
  final String confirmPassword;
  const ConfirmPasswordChangedEvent(this.confirmPassword);
  @override
  List<Object?> get props => [confirmPassword];
}

class TogglePasswordVisibilityEvent extends AuthEvent {}

class ToggleConfirmPasswordVisibilityEvent extends AuthEvent {}

class SpecialtyChangedEvent extends AuthEvent {
  final String specialty;
  const SpecialtyChangedEvent(this.specialty);
  @override
  List<Object?> get props => [specialty];
}

class SubSpecialtyChangedEvent extends AuthEvent {
  final String subSpecialty;
  const SubSpecialtyChangedEvent(this.subSpecialty);
  @override
  List<Object?> get props => [subSpecialty];
}

class MedicalLicenseChangedEvent extends AuthEvent {
  final String license;
  const MedicalLicenseChangedEvent(this.license);
  @override
  List<Object?> get props => [license];
}

class YearsOfExperienceChangedEvent extends AuthEvent {
  final String years;
  const YearsOfExperienceChangedEvent(this.years);
  @override
  List<Object?> get props => [years];
}

class EducationChangedEvent extends AuthEvent {
  final String education;
  const EducationChangedEvent(this.education);
  @override
  List<Object?> get props => [education];
}

class AboutChangedEvent extends AuthEvent {
  final String about;
  const AboutChangedEvent(this.about);
  @override
  List<Object?> get props => [about];
}

class PickProfileImageEvent extends AuthEvent {
  final String path;
  const PickProfileImageEvent(this.path);
  @override
  List<Object?> get props => [path];
}

class PickMedicalLicenseEvent extends AuthEvent {
  final String path;
  const PickMedicalLicenseEvent(this.path);
  @override
  List<Object?> get props => [path];
}

class PickCertificatesEvent extends AuthEvent {
  final String path;
  const PickCertificatesEvent(this.path);
  @override
  List<Object?> get props => [path];
}

class PickNationalIdEvent extends AuthEvent {
  final String path;
  const PickNationalIdEvent(this.path);
  @override
  List<Object?> get props => [path];
}

class OtpChangedEvent extends AuthEvent {
  final String otp;
  const OtpChangedEvent(this.otp);
  @override
  List<Object?> get props => [otp];
}

// ─── Hospital Registration Events ────────────────────────────────────────────

class OrganizationNameChangedEvent extends AuthEvent {
  final String name;
  const OrganizationNameChangedEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class OrganizationTypeChangedEvent extends AuthEvent {
  final String type;
  const OrganizationTypeChangedEvent(this.type);
  @override
  List<Object?> get props => [type];
}

class OrganizationNumberChangedEvent extends AuthEvent {
  final String number;
  const OrganizationNumberChangedEvent(this.number);
  @override
  List<Object?> get props => [number];
}

class PickOrganizationImageEvent extends AuthEvent {
  final String path;
  const PickOrganizationImageEvent(this.path);
  @override
  List<Object?> get props => [path];
}

class GovernorateChangedEvent extends AuthEvent {
  final String governorate;
  const GovernorateChangedEvent(this.governorate);
  @override
  List<Object?> get props => [governorate];
}

class CityChangedEvent extends AuthEvent {
  final String city;
  const CityChangedEvent(this.city);
  @override
  List<Object?> get props => [city];
}

class FullAddressChangedEvent extends AuthEvent {
  final String address;
  const FullAddressChangedEvent(this.address);
  @override
  List<Object?> get props => [address];
}

class PaymentMethodChangedEvent extends AuthEvent {
  final String method; // 'bank' | 'wallet'
  const PaymentMethodChangedEvent(this.method);
  @override
  List<Object?> get props => [method];
}

class AccountHolderNameChangedEvent extends AuthEvent {
  final String name;
  const AccountHolderNameChangedEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class BankNameChangedEvent extends AuthEvent {
  final String bankName;
  const BankNameChangedEvent(this.bankName);
  @override
  List<Object?> get props => [bankName];
}

class AccountNumberChangedEvent extends AuthEvent {
  final String number;
  const AccountNumberChangedEvent(this.number);
  @override
  List<Object?> get props => [number];
}

class ExpiryDateChangedEvent extends AuthEvent {
  final String date;
  const ExpiryDateChangedEvent(this.date);
  @override
  List<Object?> get props => [date];
}

class CvvChangedEvent extends AuthEvent {
  final String cvv;
  const CvvChangedEvent(this.cvv);
  @override
  List<Object?> get props => [cvv];
}

class SubmitRegistrationEvent extends AuthEvent {
  const SubmitRegistrationEvent();
}

class ResetAuthStatusEvent extends AuthEvent {
  const ResetAuthStatusEvent();
}

class VerifyOtpSubmittedEvent extends AuthEvent {
  const VerifyOtpSubmittedEvent();
}

class LoginSubmittedEvent extends AuthEvent {
  final String phone;
  final String password;

  const LoginSubmittedEvent({required this.phone, required this.password});

  @override
  List<Object?> get props => [phone, password];
}

class ResendOtpSubmittedEvent extends AuthEvent {
  const ResendOtpSubmittedEvent();
}

class CheckPhoneSubmittedEvent extends AuthEvent {
  final String? phone;

  const CheckPhoneSubmittedEvent({this.phone});

  @override
  List<Object?> get props => [phone];
}

class LogoutSubmittedEvent extends AuthEvent {
  const LogoutSubmittedEvent();
}
