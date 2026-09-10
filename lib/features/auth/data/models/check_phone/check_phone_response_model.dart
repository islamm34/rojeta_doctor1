class CheckPhoneResponseModel {
  final bool exists;
  final String? message;

  CheckPhoneResponseModel({required this.exists, this.message});

  factory CheckPhoneResponseModel.fromJson(Map<String, dynamic> json) {
    final dynamic data = json['data'];
    final bool exists = data is Map<String, dynamic>
        ? (data['exists'] as bool? ?? false)
        : (data is bool ? data : (json['exists'] as bool? ?? false));
    return CheckPhoneResponseModel(
      exists: exists,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'exists': exists, 'message': message};
  }
}
