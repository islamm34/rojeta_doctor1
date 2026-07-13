import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadSettingsEvent extends SettingsEvent {}

class TogglePushNotificationsEvent extends SettingsEvent {
  final bool isEnabled;

  const TogglePushNotificationsEvent({required this.isEnabled});

  @override
  List<Object> get props => [isEnabled];
}

enum AlertPreferenceType {
  newBookings,
  appointmentReminders,
  emergencyRequests,
  paymentNotifications,
}

class ToggleAlertPreferenceEvent extends SettingsEvent {
  final AlertPreferenceType type;
  final bool isEnabled;

  const ToggleAlertPreferenceEvent({required this.type, required this.isEnabled});

  @override
  List<Object> get props => [type, isEnabled];
}

class ChangeLanguageEvent extends SettingsEvent {
  final String languageCode;

  const ChangeLanguageEvent({required this.languageCode});

  @override
  List<Object> get props => [languageCode];
}
