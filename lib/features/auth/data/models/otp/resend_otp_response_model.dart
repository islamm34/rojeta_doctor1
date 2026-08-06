class ResendOtpResponseModel {
  final String? message;
  final String? otp;

  ResendOtpResponseModel({
    this.message,
    this.otp,
  });

  factory ResendOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return ResendOtpResponseModel(
      message: json['message'] as String?,
      otp: json['otp'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'otp': otp,
    };
  }
}
