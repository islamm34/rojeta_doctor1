import '../../domain/entities/general_settings.dart';

class GeneralSettingsModel extends GeneralSettings {
  const GeneralSettingsModel({
    super.emailNotifications,
    super.bookingUpdates,
    super.pushNotifications,
    super.appointmentReminders,
    super.marketingEmails,
    super.language,
  });

  factory GeneralSettingsModel.fromJson(Map<String, dynamic> json) {
    return GeneralSettingsModel(
      emailNotifications: json['emailNotifications'] as bool? ?? false,
      bookingUpdates: json['bookingUpdates'] as bool? ?? false,
      pushNotifications: json['pushNotifications'] as bool? ?? false,
      appointmentReminders: json['appointmentReminders'] as bool? ?? false,
      marketingEmails: json['marketingEmails'] as bool? ?? false,
      language: json['language'] as String? ?? 'English',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailNotifications': emailNotifications,
      'bookingUpdates': bookingUpdates,
      'pushNotifications': pushNotifications,
      'appointmentReminders': appointmentReminders,
      'marketingEmails': marketingEmails,
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
}
