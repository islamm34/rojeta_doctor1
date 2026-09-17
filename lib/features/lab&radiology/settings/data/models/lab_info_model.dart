import 'package:equatable/equatable.dart';

class LabInfoModel extends Equatable {
  final String? labName;
  final String? licenseNumber;
  final String? primaryContactEmail;
  final String? phoneNumber;
  final String? laboratoryDescription;
  final bool? isVerified;
  final String? verificationYear;

  const LabInfoModel({
    this.labName,
    this.licenseNumber,
    this.primaryContactEmail,
    this.phoneNumber,
    this.laboratoryDescription,
    this.isVerified,
    this.verificationYear,
  });

  factory LabInfoModel.fromJson(Map<String, dynamic> json) {
    return LabInfoModel(
      labName: (json['labName'] ?? json['lab_name'] ?? json['name']) as String?,
      licenseNumber: (json['licenseNumber'] ?? json['license_number'] ?? json['license_no']) as String?,
      primaryContactEmail: (json['primaryContactEmail'] ?? json['primary_contact_email'] ?? json['email']) as String?,
      phoneNumber: (json['phoneNumber'] ?? json['phone_number'] ?? json['phone']) as String?,
      laboratoryDescription: (json['laboratoryDescription'] ?? json['laboratory_description'] ?? json['description'] ?? json['about']) as String?,
      isVerified: json['isVerified'] as bool? ?? json['is_verified'] as bool? ?? false,
      verificationYear: (json['verificationYear'] ?? json['verification_year'] ?? json['year'])?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lab_name': labName,
      'license_number': licenseNumber,
      'primary_contact_email': primaryContactEmail,
      'phone_number': phoneNumber,
      'laboratory_description': laboratoryDescription,
      'is_verified': isVerified,
      'verification_year': verificationYear,
    };
  }

  LabInfoModel copyWith({
    String? labName,
    String? licenseNumber,
    String? primaryContactEmail,
    String? phoneNumber,
    String? laboratoryDescription,
    bool? isVerified,
    String? verificationYear,
  }) {
    return LabInfoModel(
      labName: labName ?? this.labName,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      primaryContactEmail: primaryContactEmail ?? this.primaryContactEmail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      laboratoryDescription: laboratoryDescription ?? this.laboratoryDescription,
      isVerified: isVerified ?? this.isVerified,
      verificationYear: verificationYear ?? this.verificationYear,
    );
  }

  @override
  List<Object?> get props => [
        labName,
        licenseNumber,
        primaryContactEmail,
        phoneNumber,
        laboratoryDescription,
        isVerified,
        verificationYear,
      ];
}
