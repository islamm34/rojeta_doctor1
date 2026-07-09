import 'user_type_model.dart';

class RegisterRequestModel {
  // Step 1: User Type
  final UserType? userType;

  // Step 2: Basic Information
  final String? fullName;
  final String? email;
  final String? phone;
  final String? password;

  // Step 3: Professional Information
  final String? specialty;
  final String? subSpecialty;
  final String? medicalLicenseNumber;
  final String? yearsOfExperience;
  final String? education;
  final String? about;

  // Steps 4 and 5 will be added here later

  RegisterRequestModel({
    this.userType,
    this.fullName,
    this.email,
    this.phone,
    this.password,
    this.specialty,
    this.subSpecialty,
    this.medicalLicenseNumber,
    this.yearsOfExperience,
    this.education,
    this.about,
  });

  Map<String, dynamic> toJson() {
    return {
      if (userType != null) 'userType': userType!.name,
      if (fullName != null) 'fullName': fullName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (password != null) 'password': password,
      if (specialty != null) 'specialty': specialty,
      if (subSpecialty != null) 'subSpecialty': subSpecialty,
      if (medicalLicenseNumber != null) 'medicalLicenseNumber': medicalLicenseNumber,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
      if (education != null) 'education': education,
      if (about != null) 'about': about,
    };
  }

  // To update fields progressively step by step
  RegisterRequestModel copyWith({
    UserType? userType,
    String? fullName,
    String? email,
    String? phone,
    String? password,
    String? specialty,
    String? subSpecialty,
    String? medicalLicenseNumber,
    String? yearsOfExperience,
    String? education,
    String? about,
  }) {
    return RegisterRequestModel(
      userType: userType ?? this.userType,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      specialty: specialty ?? this.specialty,
      subSpecialty: subSpecialty ?? this.subSpecialty,
      medicalLicenseNumber: medicalLicenseNumber ?? this.medicalLicenseNumber,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      education: education ?? this.education,
      about: about ?? this.about,
    );
  }
}
