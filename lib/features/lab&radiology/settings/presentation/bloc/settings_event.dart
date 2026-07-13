import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettingsData extends SettingsEvent {}

class ToggleEmailNotifications extends SettingsEvent {
  final bool value;
  const ToggleEmailNotifications(this.value);
  @override
  List<Object?> get props => [value];
}

class ToggleBookingUpdates extends SettingsEvent {
  final bool value;
  const ToggleBookingUpdates(this.value);
  @override
  List<Object?> get props => [value];
}

class TogglePushNotifications extends SettingsEvent {
  final bool value;
  const TogglePushNotifications(this.value);
  @override
  List<Object?> get props => [value];
}

class ToggleAppointmentReminders extends SettingsEvent {
  final bool value;
  const ToggleAppointmentReminders(this.value);
  @override
  List<Object?> get props => [value];
}

class LoadLabInfoEvent extends SettingsEvent {}

class UpdateLabInfoEvent extends SettingsEvent {
  final String labName;
  final String licenseNumber;
  final String primaryContactEmail;
  final String phoneNumber;
  final String description;

  const UpdateLabInfoEvent({
    required this.labName,
    required this.licenseNumber,
    required this.primaryContactEmail,
    required this.phoneNumber,
    required this.description,
  });

  @override
  List<Object?> get props => [
        labName,
        licenseNumber,
        primaryContactEmail,
        phoneNumber,
        description,
      ];
}

class LoadWorkingHoursEvent extends SettingsEvent {}

class UpdateDayScheduleEvent extends SettingsEvent {
  final String dayName;
  final bool isClosed;
  final String openingTime;
  final String closingTime;

  const UpdateDayScheduleEvent({
    required this.dayName,
    required this.isClosed,
    required this.openingTime,
    required this.closingTime,
  });

  @override
  List<Object?> get props => [dayName, isClosed, openingTime, closingTime];
}

class AddSpecialDateEvent extends SettingsEvent {
  final String dateStr;
  final String eventName;
  final String? openingTime;
  final String? closingTime;
  final bool isClosed;

  const AddSpecialDateEvent({
    required this.dateStr,
    required this.eventName,
    this.openingTime,
    this.closingTime,
    required this.isClosed,
  });

  @override
  List<Object?> get props => [dateStr, eventName, openingTime, closingTime, isClosed];
}

class RemoveSpecialDateEvent extends SettingsEvent {
  final String id;

  const RemoveSpecialDateEvent(this.id);

  @override
  List<Object?> get props => [id];
}
