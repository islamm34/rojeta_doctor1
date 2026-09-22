import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class NursingStaffModel extends Equatable {
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? gender;
  final String? status;
  final List<String> skills;
  final int? yearsOfExperience;
  final String? phone;
  final List<String> selectedServices;

  const NursingStaffModel({
    this.id,
    this.name = '',
    this.imageUrl = '',
    this.gender = 'MALE',
    this.status = 'AVAILABLE',
    this.skills = const [],
    this.yearsOfExperience = 0,
    this.phone = '',
    this.selectedServices = const [],
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

  factory NursingStaffModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingStaffModel();

    List<String> skillsList = [];
    if (json['skills'] is List) {
      skillsList = (json['skills'] as List).map((e) => e.toString()).toList();
    }

    List<String> servicesList = [];
    if (json['selectedServices'] is List) {
      servicesList = (json['selectedServices'] as List)
          .map((e) => e.toString())
          .toList();
    } else if (json['services'] is List) {
      servicesList = (json['services'] as List)
          .map((e) => e.toString())
          .toList();
    }

    final rawExp =
        json['yearsOfExperience'] ??
        json['experience_years'] ??
        json['experience'] ??
        0;
    final exp = (rawExp is num)
        ? rawExp.toInt()
        : int.tryParse(rawExp.toString()) ?? 0;

    return NursingStaffModel(
      id: json['id']?.toString(),
      name: json['name'] ?? json['full_name'] ?? '',
      imageUrl: _formatImageUrl(
        json['imageUrl'] ?? json['image'] ?? json['avatar'],
      ),
      gender: (json['gender'] ?? 'MALE').toString().toUpperCase(),
      status: (json['status'] ?? 'AVAILABLE').toString().toUpperCase(),
      skills: skillsList,
      yearsOfExperience: exp,
      phone: json['phone'] ?? json['phone_number'] ?? '',
      selectedServices: servicesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'full_name': name,
      'imageUrl': imageUrl,
      'image': imageUrl,
      'gender': gender,
      'status': status,
      'skills': skills,
      'yearsOfExperience': yearsOfExperience,
      'experience_years': yearsOfExperience,
      'phone': phone,
      'phone_number': phone,
      'selectedServices': selectedServices,
      'services': selectedServices,
    };
  }

  Future<dynamic> toRequestBody() async {
    final hasLocalImage = imageUrl != null &&
        imageUrl!.isNotEmpty &&
        !imageUrl!.startsWith('http://') &&
        !imageUrl!.startsWith('https://');

    if (!hasLocalImage) {
      return toJson();
    }
    return toFormData();
  }

  Future<FormData> toFormData() async {
    final Map<String, dynamic> data = {
      if (id != null && id!.isNotEmpty) 'id': id,
      if (name != null) ...{'name': name, 'full_name': name},
      if (gender != null) 'gender': gender,
      if (status != null) 'status': status,
      if (yearsOfExperience != null) ...{
        'yearsOfExperience': yearsOfExperience,
        'experience_years': yearsOfExperience,
      },
      if (phone != null && phone!.isNotEmpty) ...{
        'phone': phone,
        'phone_number': phone,
      },
    };

    final formData = FormData.fromMap(data);

    for (int i = 0; i < skills.length; i++) {
      formData.fields.add(MapEntry('skills[]', skills[i]));
    }

    for (int i = 0; i < selectedServices.length; i++) {
      formData.fields.add(MapEntry('services[]', selectedServices[i]));
      formData.fields.add(MapEntry('selectedServices[]', selectedServices[i]));
    }

    if (imageUrl != null &&
        imageUrl!.isNotEmpty &&
        !imageUrl!.startsWith('http://') &&
        !imageUrl!.startsWith('https://')) {
      final filename = imageUrl!.split('/').last.split('\\').last;
      formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(imageUrl!, filename: filename),
        ),
      );
      formData.files.add(
        MapEntry(
          'avatar',
          await MultipartFile.fromFile(imageUrl!, filename: filename),
        ),
      );
    }

    return formData;
  }

  NursingStaffModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? gender,
    String? status,
    List<String>? skills,
    int? yearsOfExperience,
    String? phone,
    List<String>? selectedServices,
  }) {
    return NursingStaffModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      skills: skills ?? this.skills,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      phone: phone ?? this.phone,
      selectedServices: selectedServices ?? this.selectedServices,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
    gender,
    status,
    skills,
    yearsOfExperience,
    phone,
    selectedServices,
  ];
}

class NursingStaffStatsModel extends Equatable {
  final int totalStaff;
  final int available;
  final int onDuty;
  final int onLeave;

  const NursingStaffStatsModel({
    this.totalStaff = 0,
    this.available = 0,
    this.onDuty = 0,
    this.onLeave = 0,
  });

  factory NursingStaffStatsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingStaffStatsModel();

    return NursingStaffStatsModel(
      totalStaff:
          json['totalStaff'] ?? json['total_staff'] ?? json['total'] ?? 0,
      available: json['available'] ?? json['available_staff'] ?? 0,
      onDuty: json['onDuty'] ?? json['on_duty'] ?? 0,
      onLeave: json['onLeave'] ?? json['on_leave'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalStaff': totalStaff,
      'available': available,
      'onDuty': onDuty,
      'onLeave': onLeave,
    };
  }

  NursingStaffStatsModel copyWith({
    int? totalStaff,
    int? available,
    int? onDuty,
    int? onLeave,
  }) {
    return NursingStaffStatsModel(
      totalStaff: totalStaff ?? this.totalStaff,
      available: available ?? this.available,
      onDuty: onDuty ?? this.onDuty,
      onLeave: onLeave ?? this.onLeave,
    );
  }

  @override
  List<Object?> get props => [totalStaff, available, onDuty, onLeave];
}
