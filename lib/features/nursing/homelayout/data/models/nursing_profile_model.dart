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

  static String _formatImageUrl(dynamic url) {
    if (url == null) return '';
    final s = url.toString().trim();
    if (s.isEmpty) return '';
    if (s.startsWith('http://') || s.startsWith('https://')) {
      return s;
    }
    if (s.startsWith('/')) {
      return 'https://rojeta.fassla.net$s';
    }
    return 'https://rojeta.fassla.net/storage/$s';
  }

  factory NursingProfileModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingProfileModel();

    return NursingProfileModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? json['office_name'] ?? json['full_name'] ?? '',
      licenseNumber:
          json['licenseNumber'] ??
          json['license_number'] ??
          json['license'] ??
          '',
      avatarUrl: _formatImageUrl(
        json['avatarUrl'] ??
            json['avatar_url'] ??
            json['image'] ??
            json['avatar'],
      ),
      servicesCount:
          json['servicesCount'] ??
          json['services_count'] ??
          json['total_services'] ??
          0,
      nursesCount:
          json['nursesCount'] ??
          json['nurses_count'] ??
          json['total_nurses'] ??
          0,
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
  List<Object?> get props => [
    id,
    name,
    licenseNumber,
    avatarUrl,
    servicesCount,
    nursesCount,
  ];
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
    this.verificationStatus = '',
  });

  factory NursingOfficeInfoModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingOfficeInfoModel();

    return NursingOfficeInfoModel(
      officeName:
          json['officeName'] ?? json['office_name'] ?? json['name'] ?? '',
      licenseNumber: json['licenseNumber'] ?? json['license_number'] ?? '',
      email: json['email'] ?? json['contact_email'] ?? '',
      phone: json['phone'] ?? json['phone_number'] ?? '',
      description: json['description'] ?? json['about'] ?? '',
      verificationStatus:
          json['verificationStatus'] ?? json['verification_status'] ?? '',
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
    this.openTime = '',
    this.closeTime = '',
  });

  factory DailyWorkingHoursModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const DailyWorkingHoursModel(day: '');

    return DailyWorkingHoursModel(
      day: json['day'] ?? '',
      isOpen: json['isOpen'] ?? json['is_open'] ?? json['is_working'] ?? true,
      openTime:
          json['openTime'] ?? json['open_time'] ?? json['start_time'] ?? '',
      closeTime:
          json['closeTime'] ?? json['close_time'] ?? json['end_time'] ?? '',
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

  NursingWorkingHoursModel copyWith({List<DailyWorkingHoursModel>? days}) {
    return NursingWorkingHoursModel(days: days ?? this.days);
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
    this.pushNotifications = false,
    this.appointmentReminders = true,
    this.marketingEmails = false,
    this.language = 'ar',
  });

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

  factory NursingSettingsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingSettingsModel();
    final map = (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : (json['settings'] is Map<String, dynamic>
            ? json['settings'] as Map<String, dynamic>
            : json);

    return NursingSettingsModel(
      emailNotifications: _parseBool(
        map['emailNotifications'] ??
            map['email_notifications'] ??
            map['emailNotification'] ??
            map['email_notification'],
        defaultValue: true,
      ),
      bookingUpdates: _parseBool(
        map['smsUpdates'] ??
            map['sms_updates'] ??
            map['smsNotifications'] ??
            map['sms_notifications'] ??
            map['bookingUpdates'] ??
            map['booking_updates'] ??
            map['sms_update'],
        defaultValue: true,
      ),
      pushNotifications: _parseBool(
        map['pushNotifications'] ??
            map['push_notifications'] ??
            map['pushNotification'] ??
            map['push_notification'],
        defaultValue: false,
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
      language: (map['language'] ?? 'ar').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailNotifications': emailNotifications,
      'email_notifications': emailNotifications,
      'sms_updates': bookingUpdates,
      'smsUpdates': bookingUpdates,
      'sms_notifications': bookingUpdates,
      'smsNotifications': bookingUpdates,
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

class NursingCoverageAreaModel extends Equatable {
  final String id;
  final String name;
  final String city;
  final int radiusKm;
  final double extraFee;
  final bool isActive;
  final int nursesCount;

  const NursingCoverageAreaModel({
    this.id = '',
    this.name = '',
    this.city = '',
    this.radiusKm = 10,
    this.extraFee = 0.0,
    this.isActive = true,
    this.nursesCount = 0,
  });

  factory NursingCoverageAreaModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingCoverageAreaModel();

    return NursingCoverageAreaModel(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      name: (json['name'] ?? json['area_name'] ?? json['title'] ?? '').toString(),
      city: (json['city'] ?? json['governorate'] ?? json['state'] ?? '').toString(),
      radiusKm: (json['radiusKm'] ?? json['radius_km'] ?? json['radius'] ?? 10) is num
          ? (json['radiusKm'] ?? json['radius_km'] ?? json['radius'] ?? 10).toInt()
          : int.tryParse((json['radiusKm'] ?? json['radius_km'] ?? json['radius'] ?? '10').toString()) ?? 10,
      extraFee: (json['extraFee'] ?? json['extra_fee'] ?? json['delivery_fee'] ?? json['fee'] ?? 0.0) is num
          ? (json['extraFee'] ?? json['extra_fee'] ?? json['delivery_fee'] ?? json['fee'] ?? 0.0).toDouble()
          : double.tryParse((json['extraFee'] ?? json['extra_fee'] ?? json['delivery_fee'] ?? json['fee'] ?? '0.0').toString()) ?? 0.0,
      isActive: json['isActive'] ?? json['is_active'] ?? json['active'] ?? true,
      nursesCount: (json['nursesCount'] ?? json['nurses_count'] ?? json['staff_count'] ?? 0) is num
          ? (json['nursesCount'] ?? json['nurses_count'] ?? json['staff_count'] ?? 0).toInt()
          : int.tryParse((json['nursesCount'] ?? json['nurses_count'] ?? json['staff_count'] ?? '0').toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'area_name': name,
      'city': city,
      'radius_km': radiusKm,
      'radiusKm': radiusKm,
      'extra_fee': extraFee,
      'extraFee': extraFee,
      'is_active': isActive,
      'isActive': isActive,
      'nurses_count': nursesCount,
      'nursesCount': nursesCount,
    };
  }

  NursingCoverageAreaModel copyWith({
    String? id,
    String? name,
    String? city,
    int? radiusKm,
    double? extraFee,
    bool? isActive,
    int? nursesCount,
  }) {
    return NursingCoverageAreaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      radiusKm: radiusKm ?? this.radiusKm,
      extraFee: extraFee ?? this.extraFee,
      isActive: isActive ?? this.isActive,
      nursesCount: nursesCount ?? this.nursesCount,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    city,
    radiusKm,
    extraFee,
    isActive,
    nursesCount,
  ];
}

class NursingDocumentItemModel extends Equatable {
  final String id;
  final String type; // 'commercial_registration', 'medical_license', 'facility_permit', 'tax_card', 'national_id'
  final String title;
  final String description;
  final String fileUrl;
  final String fileName;
  final String status; // 'verified', 'pending', 'rejected', 'not_uploaded'
  final String rejectionReason;
  final String uploadedAt;

  const NursingDocumentItemModel({
    this.id = '',
    this.type = '',
    this.title = '',
    this.description = '',
    this.fileUrl = '',
    this.fileName = '',
    this.status = 'not_uploaded',
    this.rejectionReason = '',
    this.uploadedAt = '',
  });

  static String _formatImageUrl(dynamic url) {
    if (url == null) return '';
    final s = url.toString().trim();
    if (s.isEmpty) return '';
    if (s.startsWith('http://') || s.startsWith('https://')) {
      return s;
    }
    if (s.startsWith('/')) {
      return 'https://rojeta.fassla.net$s';
    }
    return 'https://rojeta.fassla.net/storage/$s';
  }

  factory NursingDocumentItemModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingDocumentItemModel();

    return NursingDocumentItemModel(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      type: (json['type'] ?? json['document_type'] ?? json['key'] ?? '').toString(),
      title: (json['title'] ?? json['document_name'] ?? json['name'] ?? '').toString(),
      description: (json['description'] ?? json['desc'] ?? '').toString(),
      fileUrl: _formatImageUrl(
        json['fileUrl'] ?? json['file_url'] ?? json['file'] ?? json['document_path'] ?? json['url'],
      ),
      fileName: (json['fileName'] ?? json['file_name'] ?? '').toString(),
      status: (json['status'] ?? json['verification_status'] ?? 'pending').toString().toLowerCase(),
      rejectionReason: (json['rejectionReason'] ?? json['rejection_reason'] ?? json['notes'] ?? '').toString(),
      uploadedAt: (json['uploadedAt'] ?? json['uploaded_at'] ?? json['created_at'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'document_type': type,
      'title': title,
      'description': description,
      'file_url': fileUrl,
      'fileUrl': fileUrl,
      'file_name': fileName,
      'fileName': fileName,
      'status': status,
      'verification_status': status,
      'rejection_reason': rejectionReason,
      'uploaded_at': uploadedAt,
    };
  }

  NursingDocumentItemModel copyWith({
    String? id,
    String? type,
    String? title,
    String? description,
    String? fileUrl,
    String? fileName,
    String? status,
    String? rejectionReason,
    String? uploadedAt,
  }) {
    return NursingDocumentItemModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
      status: status ?? this.status,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    title,
    description,
    fileUrl,
    fileName,
    status,
    rejectionReason,
    uploadedAt,
  ];
}

class NursingPaymentSettingsModel extends Equatable {
  final String paymentType; // 'bank_transfer', 'mobile_wallet'
  final String accountHolderName;
  final String bankName;
  final String accountNumber;
  final String iban;
  final String swiftCode;
  final String walletProvider; // 'vodafone_cash', 'instapay', 'orange_cash', 'etisalat_cash'
  final String walletNumber;
  final bool isAutoPayout;
  final String payoutSchedule;

  const NursingPaymentSettingsModel({
    this.paymentType = 'bank_transfer',
    this.accountHolderName = '',
    this.bankName = '',
    this.accountNumber = '',
    this.iban = '',
    this.swiftCode = '',
    this.walletProvider = 'instapay',
    this.walletNumber = '',
    this.isAutoPayout = true,
    this.payoutSchedule = 'weekly',
  });

  factory NursingPaymentSettingsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingPaymentSettingsModel();

    final map = (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : (json['payment_details'] is Map<String, dynamic>
            ? json['payment_details'] as Map<String, dynamic>
            : json);

    return NursingPaymentSettingsModel(
      paymentType: (map['paymentType'] ?? map['payment_type'] ?? 'bank_transfer').toString(),
      accountHolderName: (map['accountHolderName'] ?? map['account_holder_name'] ?? map['holder_name'] ?? '').toString(),
      bankName: (map['bankName'] ?? map['bank_name'] ?? '').toString(),
      accountNumber: (map['accountNumber'] ?? map['account_number'] ?? '').toString(),
      iban: (map['iban'] ?? map['iban_number'] ?? '').toString(),
      swiftCode: (map['swiftCode'] ?? map['swift_code'] ?? '').toString(),
      walletProvider: (map['walletProvider'] ?? map['wallet_provider'] ?? 'instapay').toString(),
      walletNumber: (map['walletNumber'] ?? map['wallet_number'] ?? map['phone'] ?? '').toString(),
      isAutoPayout: map['isAutoPayout'] ?? map['is_auto_payout'] ?? map['auto_payout'] ?? true,
      payoutSchedule: (map['payoutSchedule'] ?? map['payout_schedule'] ?? 'weekly').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_type': paymentType,
      'paymentType': paymentType,
      'account_holder_name': accountHolderName,
      'accountHolderName': accountHolderName,
      'bank_name': bankName,
      'bankName': bankName,
      'account_number': accountNumber,
      'accountNumber': accountNumber,
      'iban': iban,
      'swift_code': swiftCode,
      'swiftCode': swiftCode,
      'wallet_provider': walletProvider,
      'walletProvider': walletProvider,
      'wallet_number': walletNumber,
      'walletNumber': walletNumber,
      'is_auto_payout': isAutoPayout,
      'isAutoPayout': isAutoPayout,
      'payout_schedule': payoutSchedule,
      'payoutSchedule': payoutSchedule,
    };
  }

  NursingPaymentSettingsModel copyWith({
    String? paymentType,
    String? accountHolderName,
    String? bankName,
    String? accountNumber,
    String? iban,
    String? swiftCode,
    String? walletProvider,
    String? walletNumber,
    bool? isAutoPayout,
    String? payoutSchedule,
  }) {
    return NursingPaymentSettingsModel(
      paymentType: paymentType ?? this.paymentType,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      iban: iban ?? this.iban,
      swiftCode: swiftCode ?? this.swiftCode,
      walletProvider: walletProvider ?? this.walletProvider,
      walletNumber: walletNumber ?? this.walletNumber,
      isAutoPayout: isAutoPayout ?? this.isAutoPayout,
      payoutSchedule: payoutSchedule ?? this.payoutSchedule,
    );
  }

  @override
  List<Object?> get props => [
    paymentType,
    accountHolderName,
    bankName,
    accountNumber,
    iban,
    swiftCode,
    walletProvider,
    walletNumber,
    isAutoPayout,
    payoutSchedule,
  ];
}

