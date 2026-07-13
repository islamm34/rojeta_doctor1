import 'package:equatable/equatable.dart';

class SettingsModel extends Equatable {
  final bool pushNotificationsEnabled;
  final String languageCode;
  final bool newBookingsEnabled;
  final bool appointmentRemindersEnabled;
  final bool emergencyRequestsEnabled;
  final bool paymentNotificationsEnabled;

  const SettingsModel({
    required this.pushNotificationsEnabled,
    required this.languageCode,
    this.newBookingsEnabled = true,
    this.appointmentRemindersEnabled = true,
    this.emergencyRequestsEnabled = true,
    this.paymentNotificationsEnabled = false,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      pushNotificationsEnabled: json['pushNotificationsEnabled'] ?? true,
      languageCode: json['languageCode'] ?? 'en',
      newBookingsEnabled: json['newBookingsEnabled'] ?? true,
      appointmentRemindersEnabled: json['appointmentRemindersEnabled'] ?? true,
      emergencyRequestsEnabled: json['emergencyRequestsEnabled'] ?? true,
      paymentNotificationsEnabled: json['paymentNotificationsEnabled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pushNotificationsEnabled': pushNotificationsEnabled,
      'languageCode': languageCode,
      'newBookingsEnabled': newBookingsEnabled,
      'appointmentRemindersEnabled': appointmentRemindersEnabled,
      'emergencyRequestsEnabled': emergencyRequestsEnabled,
      'paymentNotificationsEnabled': paymentNotificationsEnabled,
    };
  }

  @override
  List<Object?> get props => [
        pushNotificationsEnabled,
        languageCode,
        newBookingsEnabled,
        appointmentRemindersEnabled,
        emergencyRequestsEnabled,
        paymentNotificationsEnabled,
      ];
}
