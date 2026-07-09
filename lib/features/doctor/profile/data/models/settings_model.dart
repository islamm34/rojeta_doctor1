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

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      emailNotifications: json['emailNotifications'] ?? true,
      smsNotifications: json['smsNotifications'] ?? true,
      pushNotifications: json['pushNotifications'] ?? true,
      appointmentReminders: json['appointmentReminders'] ?? true,
      marketingEmails: json['marketingEmails'] ?? false,
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
