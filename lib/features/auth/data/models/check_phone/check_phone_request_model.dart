class CheckPhoneRequestModel {
  final String phone;

  CheckPhoneRequestModel({
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
    };
  }
}
