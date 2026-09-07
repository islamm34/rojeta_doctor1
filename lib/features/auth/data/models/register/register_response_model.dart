import '../../../../../core/local/user_data.dart';

class RegisterResponseModel {
  final String? message;
  final String? token;
  final UserData? user;
  final Map<String, dynamic>? rawUser;

  RegisterResponseModel({
    this.message,
    this.token,
    this.user,
    this.rawUser,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    final dataMap = (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : null;

    final tokenStr = (json['token'] ?? dataMap?['token']) as String?;
    final userJson = (json['user'] ?? dataMap?['user'] ?? dataMap) as Map<String, dynamic>?;

    UserData? userData;
    if (userJson != null && userJson.isNotEmpty) {
      userData = UserData.fromJson(userJson, token: tokenStr);
    }

    return RegisterResponseModel(
      message: (json['message'] ?? dataMap?['message']) as String?,
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
