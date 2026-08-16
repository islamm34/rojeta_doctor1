import 'package:dio/dio.dart';

/// Request model for hospital registration.
class HospitalRegisterRequestModel {
  final String role;
  final String name;
  final String? email;
  final String phoneNumber;
  final String password;
  final String? passwordConfirmation;
  final String organizationName;
  final String organizationType;
  final String organizationNumber;
  final String licenseNumber;
  final String? about;
  final String? logoPath;
  final String? imagePath;
  final String? governorate;
  final String? city;
  final String? fullAddress;
  final String? paymentMethod;
  final String? accountHolderName;
  final String? bankName;
  final String? accountNumber;
  final String? expiryDate;
  final String? medicalLicensePath;
  final String? certificatesPath;
  final String? taxIdPath;

  const HospitalRegisterRequestModel({
    this.role = 'hospital',
    required this.name,
    this.email,
    required this.phoneNumber,
    required this.password,
    this.passwordConfirmation,
    required this.organizationName,
    required this.organizationType,
    required this.organizationNumber,
    required this.licenseNumber,
    this.about,
    this.logoPath,
    this.imagePath,
    this.governorate,
    this.city,
    this.fullAddress,
    this.paymentMethod,
    this.accountHolderName,
    this.bankName,
    this.accountNumber,
    this.expiryDate,
    this.medicalLicensePath,
    this.certificatesPath,
    this.taxIdPath,
  });

  factory HospitalRegisterRequestModel.fromJson(Map<String, dynamic> json) {
    return HospitalRegisterRequestModel(
      role: json['role'] as String? ?? 'hospital',
      name: json['name'] as String? ?? '',
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String? ?? '',
      password: json['password'] as String? ?? '',
      passwordConfirmation: json['password_confirmation'] as String?,
      organizationName: json['organization_name'] as String? ?? '',
      organizationType: json['organization_type'] as String? ?? '',
      organizationNumber: json['organization_number'] as String? ?? '',
      licenseNumber: json['license_number'] as String? ?? '',
      about: json['about'] as String?,
      logoPath: json['logo'] as String?,
      imagePath: json['image'] as String?,
      governorate: json['governorate'] as String?,
      city: json['city'] as String?,
      fullAddress: json['full_address'] as String?,
      paymentMethod: json['payment_method'] as String?,
      accountHolderName: json['account_holder_name'] as String?,
      bankName: json['bank_name'] as String?,
      accountNumber: json['account_number'] as String?,
      expiryDate: json['expiry_date'] as String?,
      medicalLicensePath: json['medical_license'] as String?,
      certificatesPath: json['certificates'] as String?,
      taxIdPath: json['tax_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'role': role,
        'name': name,
        if (email != null && email!.isNotEmpty) 'email': email,
        'phone_number': phoneNumber,
        'password': password,
        'password_confirmation': passwordConfirmation ?? password,
        'organization_name': organizationName,
        'organization_type': organizationType,
        'organization_number': organizationNumber,
        'license_number': licenseNumber,
        if (about != null && about!.isNotEmpty) 'about': about,
        if (logoPath != null && logoPath!.isNotEmpty) 'logo': logoPath,
        if (imagePath != null && imagePath!.isNotEmpty) 'image': imagePath,
        if (governorate != null && governorate!.isNotEmpty)
          'governorate': governorate,
        if (city != null && city!.isNotEmpty) 'city': city,
        if (fullAddress != null && fullAddress!.isNotEmpty)
          'full_address': fullAddress,
        if (paymentMethod != null && paymentMethod!.isNotEmpty)
          'payment_method': paymentMethod,
        if (accountHolderName != null && accountHolderName!.isNotEmpty)
          'account_holder_name': accountHolderName,
        if (bankName != null && bankName!.isNotEmpty) 'bank_name': bankName,
        if (accountNumber != null && accountNumber!.isNotEmpty)
          'account_number': accountNumber,
        if (expiryDate != null && expiryDate!.isNotEmpty)
          'expiry_date': expiryDate,
        if (medicalLicensePath != null && medicalLicensePath!.isNotEmpty)
          'medical_license': medicalLicensePath,
        if (certificatesPath != null && certificatesPath!.isNotEmpty)
          'certificates': certificatesPath,
        if (taxIdPath != null && taxIdPath!.isNotEmpty) 'tax_id': taxIdPath,
      };

  Future<FormData> toFormData() async {
    final Map<String, dynamic> map = {};

    void addIfNotEmpty(String key, String? val) {
      if (val != null && val.trim().isNotEmpty) {
        map[key] = val.trim();
      }
    }

    addIfNotEmpty('role', role);
    addIfNotEmpty('name', name);
    addIfNotEmpty('email', email);
    addIfNotEmpty('phone_number', phoneNumber);
    addIfNotEmpty('password', password);
    addIfNotEmpty('password_confirmation', passwordConfirmation ?? password);
    addIfNotEmpty('organization_name', organizationName);
    addIfNotEmpty('organization_type', organizationType);
    addIfNotEmpty('organization_number', organizationNumber);
    addIfNotEmpty('license_number', licenseNumber);
    addIfNotEmpty('about', about);
    addIfNotEmpty('governorate', governorate);
    addIfNotEmpty('city', city);
    addIfNotEmpty('full_address', fullAddress);
    addIfNotEmpty('payment_method', paymentMethod);
    addIfNotEmpty('account_holder_name', accountHolderName);
    addIfNotEmpty('bank_name', bankName);
    addIfNotEmpty('account_number', accountNumber);
    addIfNotEmpty('expiry_date', expiryDate);

    if (medicalLicensePath != null && medicalLicensePath!.trim().isNotEmpty) {
      final path = medicalLicensePath!.trim();
      if (!path.startsWith('http')) {
        map['medical_license'] = await MultipartFile.fromFile(
          path,
          filename: path.split('/').last.split('\\').last,
        );
      } else {
        map['medical_license'] = path;
      }
    }

    if (logoPath != null && logoPath!.trim().isNotEmpty) {
      final path = logoPath!.trim();
      if (!path.startsWith('http')) {
        map['logo'] = await MultipartFile.fromFile(
          path,
          filename: path.split('/').last.split('\\').last,
        );
      } else {
        map['logo'] = path;
      }
    }

    return FormData.fromMap(map);
  }
}
