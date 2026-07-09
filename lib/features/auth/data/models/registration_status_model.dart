class RegistrationStatusModel {
  final String requestNumber;
  final String status;
  final String doctorName;
  final String phoneNumber;
  final bool isPhoneVerified;
  final List<String> uploadedDocuments;

  const RegistrationStatusModel({
    required this.requestNumber,
    required this.status,
    required this.doctorName,
    required this.phoneNumber,
    required this.isPhoneVerified,
    this.uploadedDocuments = const [],
  });

  factory RegistrationStatusModel.fromJson(Map<String, dynamic> json) {
    return RegistrationStatusModel(
      requestNumber: json['requestNumber'] as String? ?? '',
      status: json['status'] as String? ?? '',
      doctorName: json['doctorName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      uploadedDocuments: (json['uploadedDocuments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestNumber': requestNumber,
      'status': status,
      'doctorName': doctorName,
      'phoneNumber': phoneNumber,
      'isPhoneVerified': isPhoneVerified,
      'uploadedDocuments': uploadedDocuments,
    };
  }
}
