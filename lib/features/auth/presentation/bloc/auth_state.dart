import 'package:equatable/equatable.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';
import '../../../../core/utils/validators.dart';

enum AuthStatus { initial, loading, loaded, error }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.message = '',
    this.selectedType,
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.specialty = '',
    this.subSpecialty = '',
    this.medicalLicenseNumber = '',
    this.yearsOfExperience = '',
    this.education = '',
    this.about = '',
    this.profileImagePath,
    this.medicalLicensePath,
    this.certificatesPath,
    this.nationalIdPath,
    this.otpCode = '',
  });

  final AuthStatus status;
  final String message;
  final UserType? selectedType;
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  
  // Professional Information
  final String specialty;
  final String subSpecialty;
  final String medicalLicenseNumber;
  final String yearsOfExperience;
  final String education;
  final String about;
  final String? profileImagePath;
  final String? medicalLicensePath;
  final String? certificatesPath;
  final String? nationalIdPath;
  final String otpCode;

  bool get isBasicInfoFormValid =>
      fullName.trim().isNotEmpty &&
      Validators.isValidEmail(email.trim()) &&
      Validators.isValidPhone(phone.trim()) &&
      password.length >= 6 &&
      confirmPassword == password;

  bool get isProfessionalInfoValid =>
      specialty.trim().isNotEmpty && yearsOfExperience.trim().isNotEmpty;

  AuthState copyWith({
    AuthStatus? status,
    String? message,
    UserType? selectedType,
    String? fullName,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    String? specialty,
    String? subSpecialty,
    String? medicalLicenseNumber,
    String? yearsOfExperience,
    String? education,
    String? about,
    String? profileImagePath,
    String? medicalLicensePath,
    String? certificatesPath,
    String? nationalIdPath,
    String? otpCode,
  }) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
      selectedType: selectedType ?? this.selectedType,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      specialty: specialty ?? this.specialty,
      subSpecialty: subSpecialty ?? this.subSpecialty,
      medicalLicenseNumber: medicalLicenseNumber ?? this.medicalLicenseNumber,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      education: education ?? this.education,
      about: about ?? this.about,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      medicalLicensePath: medicalLicensePath ?? this.medicalLicensePath,
      certificatesPath: certificatesPath ?? this.certificatesPath,
      nationalIdPath: nationalIdPath ?? this.nationalIdPath,
      otpCode: otpCode ?? this.otpCode,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        selectedType,
        fullName,
        email,
        phone,
        password,
        confirmPassword,
        isPasswordVisible,
        isConfirmPasswordVisible,
        specialty,
        subSpecialty,
        medicalLicenseNumber,
        yearsOfExperience,
        education,
        about,
        profileImagePath,
        medicalLicensePath,
        certificatesPath,
        nationalIdPath,
        otpCode,
      ];
}
