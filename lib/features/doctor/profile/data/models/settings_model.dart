class SettingsModel {
  final bool emailNotifications;
  final bool smsNotifications;
  final bool pushNotifications;
  final bool appointmentReminders;
  final bool marketingEmails;

  const SettingsModel({
    this.emailNotifications = true,
    this.smsNotifications = true,
    this.pushNotifications = true,
    this.appointmentReminders = true,
    this.marketingEmails = false,
  });

  SettingsModel copyWith({
    bool? emailNotifications,
    bool? smsNotifications,
    bool? pushNotifications,
    bool? appointmentReminders,
    bool? marketingEmails,
  }) {
    return SettingsModel(
      emailNotifications: emailNotifications ?? this.emailNotifications,
      smsNotifications: smsNotifications ?? this.smsNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      appointmentReminders: appointmentReminders ?? this.appointmentReminders,
      marketingEmails: marketingEmails ?? this.marketingEmails,
    );
  }

  static bool _parseBool(dynamic value, {bool defaultValue = false}) {
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final lower = value.toLowerCase().trim();
      if (lower == 'true' || lower == '1') return true;
      if (lower == 'false' || lower == '0') return false;
    }
    return defaultValue;
  }

  factory SettingsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SettingsModel();
    final map = (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : (json['settings'] is Map<String, dynamic>
              ? json['settings'] as Map<String, dynamic>
              : json);

    return SettingsModel(
      emailNotifications: _parseBool(
        map['emailNotifications'] ??
            map['email_notifications'] ??
            map['emailNotification'] ??
            map['email_notification'],
        defaultValue: true,
      ),
      smsNotifications: _parseBool(
        map['smsNotifications'] ??
            map['sms_notifications'] ??
            map['smsNotification'] ??
            map['sms_notification'],
        defaultValue: true,
      ),
      pushNotifications: _parseBool(
        map['pushNotifications'] ??
            map['push_notifications'] ??
            map['pushNotification'] ??
            map['push_notification'],
        defaultValue: true,
      ),
      appointmentReminders: _parseBool(
        map['appointmentReminders'] ??
            map['appointment_reminders'] ??
            map['appointmentReminder'] ??
            map['appointment_reminder'],
        defaultValue: true,
      ),
      marketingEmails: _parseBool(
        map['marketingEmails'] ??
            map['marketing_emails'] ??
            map['marketingEmail'] ??
            map['marketing_email'],
        defaultValue: false,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailNotifications': emailNotifications,
      'smsNotifications': smsNotifications,
      'pushNotifications': pushNotifications,
      'appointmentReminders': appointmentReminders,
      'marketingEmails': marketingEmails,
    };
  }
}
