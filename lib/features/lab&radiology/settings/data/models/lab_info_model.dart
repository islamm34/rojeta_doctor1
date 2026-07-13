import 'package:equatable/equatable.dart';

class LabInfoModel extends Equatable {
  final String labName;
  final String licenseNumber;
  final String primaryContactEmail;
  final String phoneNumber;
  final String laboratoryDescription;
  final bool isVerified;
  final String verificationYear;

  const LabInfoModel({
    required this.labName,
    required this.licenseNumber,
    required this.primaryContactEmail,
    required this.phoneNumber,
    required this.laboratoryDescription,
    required this.isVerified,
    required this.verificationYear,
  });

  factory LabInfoModel.fromJson(Map<String, dynamic> json) {
    return LabInfoModel(
      labName: json['labName'] ?? '',
      licenseNumber: json['licenseNumber'] ?? '',
      primaryContactEmail: json['primaryContactEmail'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      laboratoryDescription: json['laboratoryDescription'] ?? '',
      isVerified: json['isVerified'] ?? false,
      verificationYear: json['verificationYear'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'labName': labName,
      'licenseNumber': licenseNumber,
      'primaryContactEmail': primaryContactEmail,
      'phoneNumber': phoneNumber,
      'laboratoryDescription': laboratoryDescription,
      'isVerified': isVerified,
      'verificationYear': verificationYear,
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
