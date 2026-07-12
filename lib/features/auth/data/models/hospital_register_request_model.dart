import 'dart:convert';

/// Request model for hospital registration API endpoint.
/// POST /api/v1/auth/register/hospital
class HospitalRegisterRequestModel {
  // Step 2 – Basic Information
  final String fullName;
  final String email;
  final String phone;
  final String password;

  // Step 3 – Professional Information
  final String organizationName;
  final String organizationType;
  final String organizationNumber;
  final String licenseNumber;
  final String? about;
  final String? logoPath;
  final String? imagePath;

  // Step 4 – Location
  final String governorate;
  final String city;
  final String fullAddress;

  // Step 4 – Payment Details
  final String paymentMethod; // 'bank' | 'wallet'
  final String? accountHolderName;
  final String? bankName;
  final String? accountNumber;
  final String? expiryDate;

  // Step 5 – Documents (paths to uploaded files)
  final String? medicalLicensePath;
  final String? certificatesPath;
  final String? taxIdPath;

  const HospitalRegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.organizationName,
    required this.organizationType,
    required this.organizationNumber,
    required this.licenseNumber,
    this.about,
    this.logoPath,
    this.imagePath,
    required this.governorate,
    required this.city,
    required this.fullAddress,
    required this.paymentMethod,
    this.accountHolderName,
    this.bankName,
    this.accountNumber,
    this.expiryDate,
    this.medicalLicensePath,
    this.certificatesPath,
    this.taxIdPath,
  });

  Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'password': password,
        'organization_name': organizationName,
        'organization_type': organizationType,
        'organization_number': organizationNumber,
        'license_number': licenseNumber,
        if (about != null) 'about': about,
        'governorate': governorate,
        'city': city,
        'full_address': fullAddress,
        'payment_method': paymentMethod,
        if (accountHolderName != null) 'account_holder_name': accountHolderName,
        if (bankName != null) 'bank_name': bankName,
        if (accountNumber != null) 'account_number': accountNumber,
        if (expiryDate != null) 'expiry_date': expiryDate,
      };
}
