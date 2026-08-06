class ResendOtpRequestModel {
  final String phone;

  ResendOtpRequestModel({required this.phone});

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
    };
  }
}
