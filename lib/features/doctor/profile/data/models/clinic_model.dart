import 'package:dio/dio.dart';

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
    this.videoCallPrice, Object? location,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String?,
      governorate: json['governorate'] as String?,
      city: json['city'] as String?,
      fullAddress: json['fullAddress'] as String?,
      photos: (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      consultationTime: json['consultationTime'] as int?,
      workingHours: json['workingHours'] as Map<String, dynamic>? ?? {},
      clinicVisitPrice: (json['clinicVisitPrice'] as num?)?.toDouble(),
      followUpPrice: (json['followUpPrice'] as num?)?.toDouble(),
      homeVisitPrice: (json['homeVisitPrice'] as num?)?.toDouble(),
      videoCallPrice: (json['videoCallPrice'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'governorate': governorate,
      'city': city,
      'fullAddress': fullAddress,
      'photos': photos,
      'consultationTime': consultationTime,
      'workingHours': workingHours,
      'clinicVisitPrice': clinicVisitPrice,
      'followUpPrice': followUpPrice,
      'homeVisitPrice': homeVisitPrice,
      'videoCallPrice': videoCallPrice,
    };
  }

  Future<FormData> toFormData() async {
    final Map<String, dynamic> data = toJson();

    // Convert photo paths to MultipartFiles if they are local file paths
    // For simplicity, we just pass the basic fields here, assuming uploading logic
    // handles files specifically, or we can use MultipartFile.fromFile
    final formData = FormData.fromMap(data);

    for (int i = 0; i < photos.length; i++) {
      if (!photos[i].startsWith('http')) {
         formData.files.add(MapEntry(
           'photos[]',
           await MultipartFile.fromFile(photos[i]),
         ));
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
