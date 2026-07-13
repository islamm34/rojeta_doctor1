class NursingProfileModel {
  final String id;
  final String name;
  final String licenseNumber;
  final String avatarUrl;
  final int servicesCount;
  final int nursesCount;

  const NursingProfileModel({
    required this.id,
    required this.name,
    required this.licenseNumber,
    required this.avatarUrl,
    required this.servicesCount,
    required this.nursesCount,
  });

  NursingProfileModel copyWith({
    String? id,
    String? name,
    String? licenseNumber,
    String? avatarUrl,
    int? servicesCount,
    int? nursesCount,
  }) {
    return NursingProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      servicesCount: servicesCount ?? this.servicesCount,
      nursesCount: nursesCount ?? this.nursesCount,
    );
  }
}

class NursingOfficeInfoModel {
  final String officeName;
  final String licenseNumber;
  final String email;
  final String phone;
  final String description;
  final String verificationStatus;

  const NursingOfficeInfoModel({
    required this.officeName,
    required this.licenseNumber,
    required this.email,
    required this.phone,
    required this.description,
    required this.verificationStatus,
  });

  NursingOfficeInfoModel copyWith({
    String? officeName,
    String? licenseNumber,
    String? email,
    String? phone,
    String? description,
    String? verificationStatus,
  }) {
    return NursingOfficeInfoModel(
      officeName: officeName ?? this.officeName,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }
}

class DailyWorkingHoursModel {
  final String day;
  final bool isOpen;
  final String openTime;
  final String closeTime;

  const DailyWorkingHoursModel({
    required this.day,
    required this.isOpen,
    required this.openTime,
    required this.closeTime,
  });

  DailyWorkingHoursModel copyWith({
    String? day,
    bool? isOpen,
    String? openTime,
    String? closeTime,
  }) {
    return DailyWorkingHoursModel(
      day: day ?? this.day,
      isOpen: isOpen ?? this.isOpen,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
    );
  }
}

class NursingWorkingHoursModel {
  final List<DailyWorkingHoursModel> days;

  const NursingWorkingHoursModel({required this.days});

  NursingWorkingHoursModel copyWith({
    List<DailyWorkingHoursModel>? days,
  }) {
    return NursingWorkingHoursModel(
      days: days ?? this.days,
    );
  }
}

class NursingSettingsModel {
  final bool emailNotifications;
  final bool bookingUpdates;
  final bool pushNotifications;
  final bool appointmentReminders;
  final bool marketingEmails;
  final String language;

  const NursingSettingsModel({
    required this.emailNotifications,
    required this.bookingUpdates,
    required this.pushNotifications,
    required this.appointmentReminders,
    required this.marketingEmails,
    required this.language,
  });

  NursingSettingsModel copyWith({
    bool? emailNotifications,
    bool? bookingUpdates,
    bool? pushNotifications,
    bool? appointmentReminders,
    bool? marketingEmails,
    String? language,
  }) {
    return NursingSettingsModel(
      emailNotifications: emailNotifications ?? this.emailNotifications,
      bookingUpdates: bookingUpdates ?? this.bookingUpdates,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      appointmentReminders: appointmentReminders ?? this.appointmentReminders,
      marketingEmails: marketingEmails ?? this.marketingEmails,
      language: language ?? this.language,
    );
  }
}
