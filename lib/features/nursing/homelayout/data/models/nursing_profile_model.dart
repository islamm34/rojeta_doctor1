import 'package:equatable/equatable.dart';

class NursingProfileModel extends Equatable {
  final String id;
  final String name;
  final String licenseNumber;
  final String avatarUrl;
  final int servicesCount;
  final int nursesCount;

  const NursingProfileModel({
    this.id = '',
    this.name = '',
    this.licenseNumber = '',
    this.avatarUrl = '',
    this.servicesCount = 0,
    this.nursesCount = 0,
  });

  factory NursingProfileModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingProfileModel();

    return NursingProfileModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? json['office_name'] ?? json['full_name'] ?? '',
      licenseNumber: json['licenseNumber'] ?? json['license_number'] ?? json['license'] ?? '',
      avatarUrl: json['avatarUrl'] ?? json['avatar_url'] ?? json['image'] ?? json['avatar'] ?? '',
      servicesCount: json['servicesCount'] ?? json['services_count'] ?? json['total_services'] ?? 0,
      nursesCount: json['nursesCount'] ?? json['nurses_count'] ?? json['total_nurses'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'licenseNumber': licenseNumber,
      'avatarUrl': avatarUrl,
      'servicesCount': servicesCount,
      'nursesCount': nursesCount,
    };
  }

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

  @override
  List<Object?> get props => [id, name, licenseNumber, avatarUrl, servicesCount, nursesCount];
}

class NursingOfficeInfoModel extends Equatable {
  final String officeName;
  final String licenseNumber;
  final String email;
  final String phone;
  final String description;
  final String verificationStatus;

  const NursingOfficeInfoModel({
    this.officeName = '',
    this.licenseNumber = '',
    this.email = '',
    this.phone = '',
    this.description = '',
    this.verificationStatus = 'ACTIVE STATUS',
  });

  factory NursingOfficeInfoModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingOfficeInfoModel();

    return NursingOfficeInfoModel(
      officeName: json['officeName'] ?? json['office_name'] ?? json['name'] ?? '',
      licenseNumber: json['licenseNumber'] ?? json['license_number'] ?? '',
      email: json['email'] ?? json['contact_email'] ?? '',
      phone: json['phone'] ?? json['phone_number'] ?? '',
      description: json['description'] ?? json['about'] ?? '',
      verificationStatus: json['verificationStatus'] ?? json['verification_status'] ?? 'ACTIVE STATUS',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'officeName': officeName,
      'office_name': officeName,
      'licenseNumber': licenseNumber,
      'license_number': licenseNumber,
      'email': email,
      'phone': phone,
      'phone_number': phone,
      'description': description,
      'verificationStatus': verificationStatus,
      'verification_status': verificationStatus,
    };
  }

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

  @override
  List<Object?> get props => [
        officeName,
        licenseNumber,
        email,
        phone,
        description,
        verificationStatus,
      ];
}

class DailyWorkingHoursModel extends Equatable {
  final String day;
  final bool isOpen;
  final String openTime;
  final String closeTime;

  const DailyWorkingHoursModel({
    required this.day,
    this.isOpen = true,
    this.openTime = '08:00 AM',
    this.closeTime = '06:00 PM',
  });

  factory DailyWorkingHoursModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const DailyWorkingHoursModel(day: 'Monday');

    return DailyWorkingHoursModel(
      day: json['day'] ?? 'Monday',
      isOpen: json['isOpen'] ?? json['is_open'] ?? json['is_working'] ?? true,
      openTime: json['openTime'] ?? json['open_time'] ?? json['start_time'] ?? '08:00 AM',
      closeTime: json['closeTime'] ?? json['close_time'] ?? json['end_time'] ?? '06:00 PM',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'isOpen': isOpen,
      'is_open': isOpen,
      'openTime': openTime,
      'open_time': openTime,
      'closeTime': closeTime,
      'close_time': closeTime,
    };
  }

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

  @override
  List<Object?> get props => [day, isOpen, openTime, closeTime];
}

class NursingWorkingHoursModel extends Equatable {
  final List<DailyWorkingHoursModel> days;

  const NursingWorkingHoursModel({this.days = const []});

  factory NursingWorkingHoursModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingWorkingHoursModel();

    final rawDays = json['days'] ?? json['working_days'] ?? [];
    List<DailyWorkingHoursModel> dayList = [];
    if (rawDays is List) {
      dayList = rawDays
          .whereType<Map<String, dynamic>>()
          .map((e) => DailyWorkingHoursModel.fromJson(e))
          .toList();
    }

    return NursingWorkingHoursModel(days: dayList);
  }

  Map<String, dynamic> toJson() {
    return {
      'days': days.map((e) => e.toJson()).toList(),
      'working_days': days.map((e) => e.toJson()).toList(),
    };
  }

  NursingWorkingHoursModel copyWith({
    List<DailyWorkingHoursModel>? days,
  }) {
    return NursingWorkingHoursModel(
      days: days ?? this.days,
    );
  }

  @override
  List<Object?> get props => [days];
}

class NursingSettingsModel extends Equatable {
  final bool emailNotifications;
  final bool bookingUpdates;
  final bool pushNotifications;
  final bool appointmentReminders;
  final bool marketingEmails;
  final String language;

  const NursingSettingsModel({
    this.emailNotifications = true,
    this.bookingUpdates = true,
    this.pushNotifications = true,
    this.appointmentReminders = true,
    this.marketingEmails = false,
    this.language = 'ar',
  });

  factory NursingSettingsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingSettingsModel();

    return NursingSettingsModel(
      emailNotifications: json['emailNotifications'] ?? json['email_notifications'] ?? true,
      bookingUpdates: json['bookingUpdates'] ?? json['booking_updates'] ?? true,
      pushNotifications: json['pushNotifications'] ?? json['push_notifications'] ?? true,
      appointmentReminders: json['appointmentReminders'] ?? json['appointment_reminders'] ?? true,
      marketingEmails: json['marketingEmails'] ?? json['marketing_emails'] ?? false,
      language: json['language'] ?? 'ar',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailNotifications': emailNotifications,
      'email_notifications': emailNotifications,
      'bookingUpdates': bookingUpdates,
      'booking_updates': bookingUpdates,
      'pushNotifications': pushNotifications,
      'push_notifications': pushNotifications,
      'appointmentReminders': appointmentReminders,
      'appointment_reminders': appointmentReminders,
      'marketingEmails': marketingEmails,
      'marketing_emails': marketingEmails,
      'language': language,
    };
  }

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
