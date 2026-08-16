import 'package:equatable/equatable.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';
import '../../../../core/utils/validators.dart';

enum AuthStatus { initial, loading, loaded, error }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.checkPhoneStatus = AuthStatus.initial,
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
    // Hospital registration fields
    this.organizationName = '',
    this.organizationType = '',
    this.organizationNumber = '',
    this.organizationImagePath,
    this.governorate = '',
    this.city = '',
    this.fullAddress = '',
    this.paymentMethod = 'bank',
    this.accountHolderName = '',
    this.bankName = '',
    this.accountNumber = '',
    this.expiryDate = '',
    this.cvv = '',
    this.isPhoneExists,
  });

  final AuthStatus status;
  final AuthStatus checkPhoneStatus;
  final String message;
  final UserType? selectedType;
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool? isPhoneExists;

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

  // Hospital registration fields
  final String organizationName;
  final String organizationType;
  final String organizationNumber;
  final String? organizationImagePath;
  final String governorate;
  final String city;
  final String fullAddress;
  final String paymentMethod; // 'bank' | 'wallet'
  final String accountHolderName;
  final String bankName;
  final String accountNumber;
  final String expiryDate;
  final String cvv;

  bool get isBasicInfoFormValid =>
      fullName.trim().isNotEmpty &&
      Validators.isValidEmail(email.trim()) &&
      Validators.isValidPhone(phone.trim()) &&
      password.length >= 6 &&
      confirmPassword == password;

  bool get isProfessionalInfoValid =>
      specialty.trim().isNotEmpty && yearsOfExperience.trim().isNotEmpty;

  bool get isHospitalProfessionalInfoValid =>
      organizationName.trim().isNotEmpty &&
      organizationType.trim().isNotEmpty &&
      organizationNumber.trim().isNotEmpty &&
      medicalLicenseNumber.trim().isNotEmpty &&
      password.length >= 6 &&
      confirmPassword == password;

  bool get isHospitalLocationValid =>
      governorate.trim().isNotEmpty &&
      city.trim().isNotEmpty &&
      fullAddress.trim().isNotEmpty;

  AuthState copyWith({
    AuthStatus? status,
    AuthStatus? checkPhoneStatus,
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
    // Hospital fields
    String? organizationName,
    String? organizationType,
    String? organizationNumber,
    String? organizationImagePath,
    String? governorate,
    String? city,
    String? fullAddress,
    String? paymentMethod,
    String? accountHolderName,
    String? bankName,
    String? accountNumber,
    String? expiryDate,
    String? cvv,
    bool? isPhoneExists,
  }) {
    return AuthState(
      status: status ?? this.status,
      checkPhoneStatus: checkPhoneStatus ?? this.checkPhoneStatus,
      message: message ?? this.message,
      selectedType: selectedType ?? this.selectedType,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isPhoneExists: isPhoneExists ?? this.isPhoneExists,
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
      // Hospital fields
      organizationName: organizationName ?? this.organizationName,
      organizationType: organizationType ?? this.organizationType,
      organizationNumber: organizationNumber ?? this.organizationNumber,
      organizationImagePath: organizationImagePath ?? this.organizationImagePath,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      fullAddress: fullAddress ?? this.fullAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
    );
  }

  @override
  List<Object?> get props => [
        status,
        checkPhoneStatus,
        message,
        selectedType,
        fullName,
        email,
        phone,
        password,
        confirmPassword,
        isPasswordVisible,
        isConfirmPasswordVisible,
        isPhoneExists,
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
        // Hospital fields
        organizationName,
        organizationType,
        organizationNumber,
        organizationImagePath,
        governorate,
        city,
        fullAddress,
        paymentMethod,
        accountHolderName,
        bankName,
        accountNumber,
        expiryDate,
        cvv,
      ];
}
