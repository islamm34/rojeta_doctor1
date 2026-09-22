import 'package:equatable/equatable.dart';

class SupportContactModel extends Equatable {
  final String? email;
  final String? phone;
  final String? availableHours;
  final String? averageResponseTime;
  final String? adminId;
  final String? adminName;
  final String? adminAvatar;

  const SupportContactModel({
    this.email,
    this.phone,
    this.availableHours,
    this.averageResponseTime,
    this.adminId,
    this.adminName,
    this.adminAvatar,
  });

  factory SupportContactModel.fromJson(Map<String, dynamic> json) {
    return SupportContactModel(
      email: (json['email'] ?? json['support_email'])?.toString(),
      phone: (json['phone'] ?? json['support_phone'] ?? json['hotline'])?.toString(),
      availableHours: (json['available_hours'] ??
              json['availableHours'] ??
              json['working_hours'] ??
              json['hours'])
          ?.toString(),
      averageResponseTime: (json['average_response_time'] ??
              json['averageResponseTime'] ??
              json['response_time'])
          ?.toString(),
      adminId: (json['admin_id'] ?? json['adminId'] ?? json['id'])?.toString(),
      adminName: (json['admin_name'] ?? json['adminName'] ?? json['name'])?.toString(),
      adminAvatar: (json['admin_avatar'] ??
              json['adminAvatar'] ??
              json['avatar'] ??
              json['image'])
          ?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'available_hours': availableHours,
      'average_response_time': averageResponseTime,
      'admin_id': adminId,
      'admin_name': adminName,
      'admin_avatar': adminAvatar,
    };
  }

  SupportContactModel copyWith({
    String? email,
    String? phone,
    String? availableHours,
    String? averageResponseTime,
    String? adminId,
    String? adminName,
    String? adminAvatar,
  }) {
    return SupportContactModel(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      availableHours: availableHours ?? this.availableHours,
      averageResponseTime: averageResponseTime ?? this.averageResponseTime,
      adminId: adminId ?? this.adminId,
      adminName: adminName ?? this.adminName,
      adminAvatar: adminAvatar ?? this.adminAvatar,
    );
  }

  @override
  List<Object?> get props => [
        email,
        phone,
        availableHours,
        averageResponseTime,
        adminId,
        adminName,
        adminAvatar,
      ];
}
