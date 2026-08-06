class CheckPhoneResponseModel {
  final bool exists;
  final String? message;

  CheckPhoneResponseModel({
    required this.exists,
    this.message,
  });

  factory CheckPhoneResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckPhoneResponseModel(
      exists: json['exists'] as bool? ?? false,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exists': exists,
      'message': message,
    };
  }
}
