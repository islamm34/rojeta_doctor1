import 'package:dio/dio.dart';

String _sanitizeImageUrl(dynamic url) {
  if (url == null) return '';
  final s = url.toString().trim();
  if (s.isEmpty) return '';
  if (s.contains('localhost') || s.contains('127.0.0.1')) {
    return s
        .replaceAll('http://localhost:8000', 'https://rojeta.fassla.net')
        .replaceAll('http://127.0.0.1:8000', 'https://rojeta.fassla.net')
        .replaceAll('http://localhost', 'https://rojeta.fassla.net')
        .replaceAll('https://localhost', 'https://rojeta.fassla.net')
        .replaceAll('http://127.0.0.1', 'https://rojeta.fassla.net');
  }
  return s;
}

class ClinicModel {
  final String id;
  final String name;
  final String? phone;
  final String? governorate;
  final String? city;
  final String? fullAddress;
  final List<String> photos;
  final int? consultationTime; // in minutes
  // working hours could be a Map<String, dynamic> for simplicity here
  final Map<String, dynamic> workingHours;
  final double? clinicVisitPrice;
  final double? followUpPrice;
  final double? homeVisitPrice;
  final double? videoCallPrice;

  const ClinicModel({
    required this.id,
    required this.name,
    this.phone,
    this.governorate,
    this.city,
    this.fullAddress,
    this.photos = const [],
    this.consultationTime,
    this.workingHours = const {},
    this.clinicVisitPrice,
    this.followUpPrice,
    this.homeVisitPrice,
    this.videoCallPrice,
    Object? location,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    final workingHoursRaw = json['workingHours'] ?? json['working_hours'];

    return ClinicModel(
      id: json['id']?.toString() ?? '',
      name: (json['name'] ?? json['clinic_name'] ?? '').toString(),
      phone: (json['phone'] ?? json['clinic_phone'] ?? json['phone_number'])
          ?.toString(),
      governorate: json['governorate'] as String?,
      city: json['city'] as String?,
      fullAddress:
          (json['fullAddress'] ?? json['full_address'] ?? json['address'])
              as String?,
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => _sanitizeImageUrl(e))
              .where((e) => e.isNotEmpty)
              .toList() ??
          [],
      consultationTime:
          ((json['consultationTime'] ?? json['consultation_time']) as num?)
              ?.toInt(),
      workingHours: workingHoursRaw is Map<String, dynamic>
          ? workingHoursRaw
          : (workingHoursRaw is Map
                ? Map<String, dynamic>.from(workingHoursRaw)
                : const {}),
      clinicVisitPrice:
          ((json['clinicVisitPrice'] ??
                      json['clinic_visit_price'] ??
                      json['visit_price'] ??
                      json['price'])
                  as num?)
              ?.toDouble(),
      followUpPrice:
          ((json['followUpPrice'] ?? json['follow_up_price']) as num?)
              ?.toDouble(),
      homeVisitPrice:
          ((json['homeVisitPrice'] ?? json['home_visit_price']) as num?)
              ?.toDouble(),
      videoCallPrice:
          ((json['videoCallPrice'] ?? json['video_call_price']) as num?)
              ?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) 'id': id,
      'name': name,
      'clinic_name': name,
      if (phone != null) ...{'phone': phone, 'clinic_phone': phone},
      if (governorate != null) 'governorate': governorate,
      if (city != null) 'city': city,
      if (fullAddress != null) ...{
        'fullAddress': fullAddress,
        'full_address': fullAddress,
        'address': fullAddress,
      },
      'photos': photos,
      if (consultationTime != null) ...{
        'consultationTime': consultationTime,
        'consultation_time': consultationTime,
      },
      'workingHours': workingHours,
      'working_hours': workingHours,
      if (clinicVisitPrice != null) ...{
        'clinicVisitPrice': clinicVisitPrice,
        'clinic_visit_price': clinicVisitPrice,
      },
      if (followUpPrice != null) ...{
        'followUpPrice': followUpPrice,
        'follow_up_price': followUpPrice,
      },
      if (homeVisitPrice != null) ...{
        'homeVisitPrice': homeVisitPrice,
        'home_visit_price': homeVisitPrice,
      },
      if (videoCallPrice != null) ...{
        'videoCallPrice': videoCallPrice,
        'video_call_price': videoCallPrice,
      },
    };
  }

  Future<dynamic> toRequestBody({bool isUpdate = false}) async {
    final hasLocalFiles = photos.any(
      (p) => !p.startsWith('http://') && !p.startsWith('https://'),
    );
    if (!hasLocalFiles) {
      final map = toJson();
      // Remove photos so the server's image validation rule does not reject non-file strings
      map.remove('photos');
      return map;
    }
    return toFormData(isUpdate: isUpdate);
  }

  Future<FormData> toFormData({bool isUpdate = false}) async {
    final Map<String, dynamic> data = toJson();

    // CRITICAL: Remove 'photos' from the data map so raw local file paths are not sent as strings in fields
    data.remove('photos');

    if (isUpdate) {
      data['_method'] = 'PUT';
    }

    final formData = FormData.fromMap(data);

    for (int i = 0; i < photos.length; i++) {
      final photo = photos[i];
      if (!photo.startsWith('http://') && !photo.startsWith('https://')) {
        final filename = photo.split('/').last.split('\\').last;
        formData.files.add(
          MapEntry(
            'photos[]',
            await MultipartFile.fromFile(photo, filename: filename),
          ),
        );
      }
    }

    return formData;
  }

  ClinicModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? governorate,
    String? city,
    String? fullAddress,
    List<String>? photos,
    int? consultationTime,
    Map<String, dynamic>? workingHours,
    double? clinicVisitPrice,
    double? followUpPrice,
    double? homeVisitPrice,
    double? videoCallPrice,
  }) {
    return ClinicModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      fullAddress: fullAddress ?? this.fullAddress,
      photos: photos ?? this.photos,
      consultationTime: consultationTime ?? this.consultationTime,
      workingHours: workingHours ?? this.workingHours,
      clinicVisitPrice: clinicVisitPrice ?? this.clinicVisitPrice,
      followUpPrice: followUpPrice ?? this.followUpPrice,
      homeVisitPrice: homeVisitPrice ?? this.homeVisitPrice,
      videoCallPrice: videoCallPrice ?? this.videoCallPrice,
    );
  }
}
