import 'package:rojeta_doctor/core/local/user_data.dart';

import 'profile_model.dart';
import 'payment_details_model.dart';

class UserProfileResponseModel {
  final UserData? user;
  final UserProfileDetailModel? profile;
  final Map<String, dynamic>? rawUser;
  final ProfileModel? profileModel;

  UserProfileResponseModel({
    this.user,
    this.profile,
    this.rawUser,
    this.profileModel,
  });

  factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    final dataMap = (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : json;

    // Check if this is the full doctor profile response from /doctor/profile
    if (dataMap.containsKey('fullName') || dataMap.containsKey('clinics')) {
      final model = ProfileModel.fromJson(dataMap);
      return UserProfileResponseModel(profileModel: model);
    }

    final userJson = (dataMap['user'] is Map<String, dynamic>)
        ? dataMap['user'] as Map<String, dynamic>
        : dataMap;

    UserData? userData;
    UserProfileDetailModel? profileDetail;

    if (userJson.isNotEmpty) {
      userData = UserData.fromJson(userJson);
      final profileJson = userJson['profile'] as Map<String, dynamic>?;
      if (profileJson != null) {
        profileDetail = UserProfileDetailModel.fromJson(profileJson);
      }
    }

    return UserProfileResponseModel(
      user: userData,
      profile: profileDetail,
      rawUser: userJson,
    );
  }

  ProfileModel toProfileModel() {
    if (profileModel != null) return profileModel!;
    return ProfileModel(
      id: user?.id?.toString() ?? profile?.id?.toString() ?? '',
      fullName: user?.name ?? profile?.organizationName ?? '',
      email: user?.email ?? '',
      phone: user?.phone ?? profile?.organizationNumber ?? '',
      specialty: profile?.organizationType,
      subSpecialty: null,
      yearsOfExperience: null,
      about: profile?.about,
      education: null,
      imageUrl: profile?.logo,
      isPro: false,
      clinics: const [],
      services: const [],
      paymentDetails: const PaymentDetailsModel(paymentType: 'bank_transfer'),
    );
  }
}

class UserProfileDetailModel {
  final dynamic id;
  final String? userId;
  final int? homeSampleCollection;
  final String? collectionFee;
  final num? serviceRadiusKm;
  final String? taxId;
  final String? medicalLicense;
  final List<String>? certificates;
  final List<String>? images;
  final String? createdAt;
  final String? updatedAt;
  final String? organizationName;
  final String? organizationType;
  final String? organizationNumber;
  final String? about;
  final String? logo;
  final String? governorate;
  final String? city;
  final String? fullAddress;
  final String? licenseNumber;

  UserProfileDetailModel({
    this.id,
    this.userId,
    this.homeSampleCollection,
    this.collectionFee,
    this.serviceRadiusKm,
    this.taxId,
    this.medicalLicense,
    this.certificates,
    this.images,
    this.createdAt,
    this.updatedAt,
    this.organizationName,
    this.organizationType,
    this.organizationNumber,
    this.about,
    this.logo,
    this.governorate,
    this.city,
    this.fullAddress,
    this.licenseNumber,
  });

  factory UserProfileDetailModel.fromJson(Map<String, dynamic> json) {
    return UserProfileDetailModel(
      id: json['id'],
      userId: json['user_id'] as String?,
      homeSampleCollection: json['home_sample_collection'] as int?,
      collectionFee: json['collection_fee'] as String?,
      serviceRadiusKm: json['service_radius_km'] as num?,
      taxId: json['tax_id'] as String?,
      medicalLicense: json['medical_license'] as String?,
      certificates: (json['certificates'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      organizationName: json['organization_name'] as String?,
      organizationType: json['organization_type'] as String?,
      organizationNumber: json['organization_number'] as String?,
      about: json['about'] as String?,
      logo: json['logo'] as String?,
      governorate: json['governorate'] as String?,
      city: json['city'] as String?,
      fullAddress: json['full_address'] as String?,
      licenseNumber: json['license_number'] as String?,
    );
  }
}
