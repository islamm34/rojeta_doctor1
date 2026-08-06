class VerifyOtpRequestModel {
  final String phone;
  final String code;

  VerifyOtpRequestModel({
    required this.phone,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'code': code,
    };
  }
}
