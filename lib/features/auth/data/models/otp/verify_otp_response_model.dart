import '../../../../../core/local/user_data.dart';

class VerifyOtpResponseModel {
  final String? message;
  final String? token;
  final UserData? user;
  final Map<String, dynamic>? rawUser;

  VerifyOtpResponseModel({
    this.message,
    this.token,
    this.user,
    this.rawUser,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    final tokenStr = json['token'] as String?;
    final userJson = json['user'] as Map<String, dynamic>?;

    UserData? userData;
    if (userJson != null) {
      userData = UserData.fromJson(userJson, token: tokenStr);
    }

    return VerifyOtpResponseModel(
      message: json['message'] as String?,
      token: tokenStr,
      user: userData,
      rawUser: userJson,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'user': rawUser ?? user?.toJson(),
    };
  }
}
