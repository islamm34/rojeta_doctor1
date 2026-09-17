import 'package:equatable/equatable.dart';

class GeneralSettingsModel extends Equatable {
  final bool? emailNotifications;
  final bool? bookingUpdates;
  final bool? pushNotifications;
  final bool? appointmentReminders;
  final bool? marketingEmails;
  final String? language;

  const GeneralSettingsModel({
    this.emailNotifications = false,
    this.bookingUpdates = false,
    this.pushNotifications = false,
    this.appointmentReminders = false,
    this.marketingEmails = false,
    this.language = 'English',
  });

  factory GeneralSettingsModel.fromJson(Map<String, dynamic> json) {
    return GeneralSettingsModel(
      emailNotifications:
          json['emailNotifications'] as bool? ??
          json['email_notifications'] as bool? ??
          false,
      bookingUpdates:
          json['bookingUpdates'] as bool? ??
          json['booking_updates'] as bool? ??
          false,
      pushNotifications:
          json['pushNotifications'] as bool? ??
          json['push_notifications'] as bool? ??
          false,
      appointmentReminders:
          json['appointmentReminders'] as bool? ??
          json['appointment_reminders'] as bool? ??
          false,
      marketingEmails:
          json['marketingEmails'] as bool? ??
          json['marketing_emails'] as bool? ??
          false,
      language:
          (json['language'] ?? json['lang'] ?? json['locale']) as String? ??
          'English',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email_notifications': emailNotifications,
      'booking_updates': bookingUpdates,
      'push_notifications': pushNotifications,
      'appointment_reminders': appointmentReminders,
      'marketing_emails': marketingEmails,
      'language': language,
    };
  }

  GeneralSettingsModel copyWith({
    bool? emailNotifications,
    bool? bookingUpdates,
    bool? pushNotifications,
    bool? appointmentReminders,
    bool? marketingEmails,
    String? language,
  }) {
    return GeneralSettingsModel(
      emailNotifications: emailNotifications ?? this.emailNotifications,
      bookingUpdates: bookingUpdates ?? this.bookingUpdates,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      appointmentReminders: appointmentReminders ?? this.appointmentReminders,
      marketingEmails: marketingEmails ?? this.marketingEmails,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [
        emailNotifications,
        bookingUpdates,
        pushNotifications,
        appointmentReminders,
        marketingEmails,
        language,
      ];
}
