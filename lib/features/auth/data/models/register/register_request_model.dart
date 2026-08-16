import 'package:dio/dio.dart';
import '../user_type_model.dart';

class RegisterRequestModel {
  final UserType? userType;
  final String role;
  final String name;
  final String? firstName;
  final String? lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String? passwordConfirmation;
  final String? governorate;
  final String? city;
  final String? area;
  final String? fullAddress;
  final String? about;
  final String? licenseNumber;
  final String? taxId;
  final String? medicalLicense;
  final List<String>? certificates;
  final List<String>? images;
  final String? logo;

  // Doctor specific fields
  final String? specialty;
  final String? subSpecialty;
  final String? experienceYears;
  final String? education;
  final String? homeVisitPrice;
  final String? callPrice;
  final String? chatPrice;
  final List<Map<String, dynamic>>? clinics;

  // Organization specific fields (Hospital / Lab / Nursing / Radiology)
  final String? organizationName;
  final String? organizationType;
  final String? organizationNumber;

  // Sample collection / radius fields (Lab / Nursing / Radiology)
  final String? homeSampleCollection;
  final String? collectionFee;
  final String? serviceRadiusKm;
  final List<Map<String, dynamic>>? workingHours;

  RegisterRequestModel({
    this.userType,
    required this.role,
    required this.name,
    this.firstName,
    this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.passwordConfirmation,
    this.governorate,
    this.city,
    this.area,
    this.fullAddress,
    this.about,
    this.licenseNumber,
    this.taxId,
    this.medicalLicense,
    this.certificates,
    this.images,
    this.logo,
    this.specialty,
    this.subSpecialty,
    this.experienceYears,
    this.education,
    this.homeVisitPrice,
    this.callPrice,
    this.chatPrice,
    this.clinics,
    this.organizationName,
    this.organizationType,
    this.organizationNumber,
    this.homeSampleCollection,
    this.collectionFee,
    this.serviceRadiusKm,
    this.workingHours,
  });

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'name': name,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email.isNotEmpty) 'email': email,
      'phone_number': phoneNumber,
      'password': password,
      'password_confirmation': passwordConfirmation ?? password,
      if (governorate != null) 'governorate': governorate,
      if (city != null) 'city': city,
      if (area != null) 'area': area,
      if (fullAddress != null) 'full_address': fullAddress,
      if (about != null) 'about': about,
      if (licenseNumber != null) 'license_number': licenseNumber,
      if (taxId != null) 'tax_id': taxId,
      if (medicalLicense != null) 'medical_license': medicalLicense,
      if (certificates != null) 'certificates': certificates,
      if (images != null) 'images': images,
      if (logo != null) 'logo': logo,
      if (specialty != null) 'specialty': specialty,
      if (subSpecialty != null) 'sub_specialty': subSpecialty,
      if (experienceYears != null) 'experience_years': experienceYears,
      if (education != null) 'education': education,
      if (homeVisitPrice != null) 'home_visit_price': homeVisitPrice,
      if (callPrice != null) 'call_price': callPrice,
      if (chatPrice != null) 'chat_price': chatPrice,
      if (clinics != null) 'clinics': clinics,
      if (organizationName != null) 'organization_name': organizationName,
      if (organizationType != null) 'organization_type': organizationType,
      if (organizationNumber != null) 'organization_number': organizationNumber,
      if (homeSampleCollection != null)
        'home_sample_collection': homeSampleCollection,
      if (collectionFee != null) 'collection_fee': collectionFee,
      if (serviceRadiusKm != null) 'service_radius_km': serviceRadiusKm,
      if (workingHours != null) 'working_hours': workingHours,
    };
  }

  Future<FormData> toFormData() async {
    final Map<String, dynamic> map = {};

    void addIfNotEmpty(String key, String? val) {
      if (val != null && val.trim().isNotEmpty) {
        map[key] = val.trim();
      }
    }

    addIfNotEmpty('role', role);
    addIfNotEmpty('name', name);
    addIfNotEmpty('first_name', firstName);
    addIfNotEmpty('last_name', lastName);
    addIfNotEmpty('email', email);
    addIfNotEmpty('phone_number', phoneNumber);
    addIfNotEmpty('password', password);
    addIfNotEmpty('password_confirmation', passwordConfirmation ?? password);
    addIfNotEmpty('governorate', governorate);
    addIfNotEmpty('city', city);
    addIfNotEmpty('area', area);
    addIfNotEmpty('full_address', fullAddress);
    addIfNotEmpty('about', about);
    addIfNotEmpty('license_number', licenseNumber);
    addIfNotEmpty('tax_id', taxId);
    addIfNotEmpty('specialty', specialty);
    addIfNotEmpty('sub_specialty', subSpecialty);
    addIfNotEmpty('experience_years', experienceYears);
    addIfNotEmpty('education', education);
    addIfNotEmpty('home_visit_price', homeVisitPrice);
    addIfNotEmpty('call_price', callPrice);
    addIfNotEmpty('chat_price', chatPrice);
    addIfNotEmpty('organization_name', organizationName);
    addIfNotEmpty('organization_type', organizationType);
    addIfNotEmpty('organization_number', organizationNumber);
    addIfNotEmpty('home_sample_collection', homeSampleCollection);
    addIfNotEmpty('collection_fee', collectionFee);
    addIfNotEmpty('service_radius_km', serviceRadiusKm);

    // Single File inputs
    if (medicalLicense != null && medicalLicense!.trim().isNotEmpty) {
      final path = medicalLicense!.trim();
      if (_isFile(path)) {
        map['medical_license'] = await MultipartFile.fromFile(
          path,
          filename: _getFilename(path),
        );
      } else {
        map['medical_license'] = path;
      }
    }

    if (logo != null && logo!.trim().isNotEmpty) {
      final path = logo!.trim();
      if (_isFile(path)) {
        map['logo'] = await MultipartFile.fromFile(
          path,
          filename: _getFilename(path),
        );
      } else {
        map['logo'] = path;
      }
    }

    // List File inputs
    if (certificates != null && certificates!.isNotEmpty) {
      final List<dynamic> certList = [];
      for (final path in certificates!) {
        if (path.trim().isNotEmpty) {
          if (_isFile(path)) {
            certList.add(await MultipartFile.fromFile(
              path.trim(),
              filename: _getFilename(path.trim()),
            ));
          } else {
            certList.add(path.trim());
          }
        }
      }
      if (certList.isNotEmpty) map['certificates'] = certList;
    }

    if (images != null && images!.isNotEmpty) {
      final List<dynamic> imgList = [];
      for (final path in images!) {
        if (path.trim().isNotEmpty) {
          if (_isFile(path)) {
            imgList.add(await MultipartFile.fromFile(
              path.trim(),
              filename: _getFilename(path.trim()),
            ));
          } else {
            imgList.add(path.trim());
          }
        }
      }
      if (imgList.isNotEmpty) map['images'] = imgList;
    }

    // Nested Lists: clinics & working_hours
    if (clinics != null && clinics!.isNotEmpty) {
      map['clinics'] = clinics;
    }
    if (workingHours != null && workingHours!.isNotEmpty) {
      map['working_hours'] = workingHours;
    }

    return FormData.fromMap(map);
  }

  static bool _isFile(String path) {
    return !path.startsWith('http://') && !path.startsWith('https://');
  }

  static String _getFilename(String path) {
    return path.split('/').last.split('\\').last;
  }
}
