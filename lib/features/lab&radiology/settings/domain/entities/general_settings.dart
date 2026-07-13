import 'package:equatable/equatable.dart';

class GeneralSettings extends Equatable {
  final bool emailNotifications;
  final bool bookingUpdates;
  final bool pushNotifications;
  final bool appointmentReminders;
  final bool marketingEmails;
  final String language;

  const GeneralSettings({
    this.emailNotifications = false,
    this.bookingUpdates = false,
    this.pushNotifications = false,
    this.appointmentReminders = false,
    this.marketingEmails = false,
    this.language = 'English',
  });

  GeneralSettings copyWith({
    bool? emailNotifications,
    bool? bookingUpdates,
    bool? pushNotifications,
    bool? appointmentReminders,
    bool? marketingEmails,
    String? language,
  }) {
    return GeneralSettings(
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
