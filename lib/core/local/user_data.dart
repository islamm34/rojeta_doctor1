import 'package:hive/hive.dart';

part 'user_data.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  dynamic id;

  @HiveField(1)
  String? phone;

  @HiveField(2)
  String? firstName;

  @HiveField(3)
  String? secondName;

  @HiveField(4)
  String? name;

  @HiveField(5)
  String? email;

  @HiveField(6)
  String? role;

  @HiveField(7)
  String? createdAt;

  @HiveField(8)
  String? token;

  @HiveField(9)
  String? language; // 'ar' or 'en'

  @HiveField(10)
  String? image;

  @HiveField(11)
  bool? onBoardingCompleted;

  @HiveField(12)
  bool? isVerified;

  @HiveField(13)
  int? countryId;

  @HiveField(14)
  int? cityId;

  @HiveField(15)
  int? placeRequestsCount;

  @HiveField(16)
  int? approvedRequestsCount;

  @HiveField(17)
  int? rejectedRequestsCount;

  @HiveField(18)
  int? pendingRequestsCount;

  UserData({
    this.id,
    this.phone,
    this.firstName,
    this.secondName,
    this.name,
    this.email,
    this.role,
    this.createdAt,
    this.token,
    this.language = 'ar', // Defaulting to Arabic for the Egyptian market
    this.image,
    this.onBoardingCompleted,
    this.isVerified,
    this.countryId,
    this.cityId,
    this.placeRequestsCount,
    this.approvedRequestsCount,
    this.rejectedRequestsCount,
    this.pendingRequestsCount,
  });

  UserData copyWith({
    dynamic id,
    String? phone,
    String? firstName,
    String? secondName,
    String? name,
    String? email,
    String? role,
    String? createdAt,
    String? token,
    String? language,
    String? image,
    bool? onBoardingCompleted,
    bool? isVerified,
    int? countryId,
    int? cityId,
    int? placeRequestsCount,
    int? approvedRequestsCount,
    int? rejectedRequestsCount,
    int? pendingRequestsCount,
  }) {
    return UserData(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      token: token ?? this.token,
      language: language ?? this.language,
      image: image ?? this.image,
      onBoardingCompleted: onBoardingCompleted ?? this.onBoardingCompleted,
      isVerified: isVerified ?? this.isVerified,
      countryId: countryId ?? this.countryId,
      cityId: cityId ?? this.cityId,
      placeRequestsCount: placeRequestsCount ?? this.placeRequestsCount,
      approvedRequestsCount: approvedRequestsCount ?? this.approvedRequestsCount,
      rejectedRequestsCount: rejectedRequestsCount ?? this.rejectedRequestsCount,
      pendingRequestsCount: pendingRequestsCount ?? this.pendingRequestsCount,
    );
  }

  set phoneSetter(String? value) {
    phone = value;
    save();
  }

  set nameSetter(String? value) {
    name = value;
    save();
  }

  set firstNameSetter(String? value) {
    firstName = value;
    save();
  }

  set secondNameSetter(String? value) {
    secondName = value;
    save();
  }

  set emailSetter(String? value) {
    email = value;
    save();
  }

  set roleSetter(String? value) {
    role = value;
    save();
  }

  set createdAtSetter(String? value) {
    createdAt = value;
    save();
  }

  set tokenSetter(String? value) {
    token = value;
    save();
  }

  set languageSetter(String? value) {
    language = value;
    save();
  }

  set imageSetter(String? value) {
    image = value;
    save();
  }

  set onBoardingCompletedSetter(bool? value) {
    onBoardingCompleted = value;
    save();
  }

  /// ✅ Factory: From JSON (Mapped to API response)
  factory UserData.fromJson(Map<String, dynamic> json, {String? token}) {
    final user = (json['user'] is Map<String, dynamic>)
        ? json['user'] as Map<String, dynamic>
        : json;

    String? extractRole(dynamic roleData) {
      if (roleData is String && roleData.trim().isNotEmpty) return roleData.trim();
      if (roleData is Map && roleData['name'] != null) {
        return roleData['name'].toString().trim();
      }
      return null;
    }

    final roleStr = extractRole(user['role']) ??
        extractRole(user['user_type']) ??
        extractRole(user['type']) ??
        (user['roles'] is List && (user['roles'] as List).isNotEmpty
            ? extractRole((user['roles'] as List).first)
            : null);

    return UserData(
      id: user['id'],
      phone: user['phone']?.toString() ?? user['phone_number']?.toString(),
      firstName: user['first_name']?.toString(),
      secondName: user['second_name']?.toString(),
      name: user['name']?.toString(),
      email: user['email']?.toString(),
      role: roleStr,
      createdAt: user['created_at']?.toString(),
      token: token ?? user['token']?.toString() ?? json['token']?.toString(),
      image: user['image_link']?.toString() ?? user['image']?.toString(),
      onBoardingCompleted: user['on_boarding_completed'] == true ||
          user['on_boarding_completed'] == 1,
      isVerified: user['is_verified'] == true || user['is_verified'] == 1,
      countryId: user['country_id'] is int
          ? user['country_id'] as int
          : int.tryParse(user['country_id']?.toString() ?? ''),
      cityId: user['city_id'] is int
          ? user['city_id'] as int
          : int.tryParse(user['city_id']?.toString() ?? ''),
      placeRequestsCount: user['place_requests_count'] is int
          ? user['place_requests_count'] as int
          : int.tryParse(user['place_requests_count']?.toString() ?? ''),
      approvedRequestsCount: user['approved_requests_count'] is int
          ? user['approved_requests_count'] as int
          : int.tryParse(user['approved_requests_count']?.toString() ?? ''),
      rejectedRequestsCount: user['rejected_requests_count'] is int
          ? user['rejected_requests_count'] as int
          : int.tryParse(user['rejected_requests_count']?.toString() ?? ''),
      pendingRequestsCount: user['pending_requests_count'] is int
          ? user['pending_requests_count'] as int
          : int.tryParse(user['pending_requests_count']?.toString() ?? ''),
    );
  }

  set citySetter(int value) {
    cityId = value;
    save();
  }

  /// ✅ To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'first_name': firstName,
      'second_name': secondName,
      'name': name,
      'email': email,
      'role': role,
      'created_at': createdAt,
      'token': token,
      'language': language,
      'image': image,
      'on_boarding_completed': onBoardingCompleted,
      'is_verified': isVerified,
      'country_id': countryId,
      'city_id': cityId,
      'place_requests_count': placeRequestsCount,
      'approved_requests_count': approvedRequestsCount,
      'rejected_requests_count': rejectedRequestsCount,
      'pending_requests_count': pendingRequestsCount,
    };
  }
}
