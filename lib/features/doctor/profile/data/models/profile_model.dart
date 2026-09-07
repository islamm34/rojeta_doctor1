import 'clinic_model.dart';
import 'payment_details_model.dart';
import 'service_pricing_model.dart';

class ProfileModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String? specialty;
  final String? subSpecialty;
  final String? yearsOfExperience;
  final String? about;
  final String? education;
  final String? imageUrl;
  final bool isPro;
  final List<ClinicModel> clinics;
  final List<ServicePricingModel> services;
  final PaymentDetailsModel paymentDetails;

  const ProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.specialty,
    this.subSpecialty,
    this.yearsOfExperience,
    this.about,
    this.education,
    this.imageUrl,
    this.isPro = false,
    this.clinics = const [],
    this.services = const [],
    required this.paymentDetails,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final paymentMap = (json['paymentDetails'] is Map<String, dynamic>)
        ? json['paymentDetails'] as Map<String, dynamic>
        : (json['payment_details'] is Map<String, dynamic>
              ? json['payment_details'] as Map<String, dynamic>
              : null);

    return ProfileModel(
      id: json['id']?.toString() ?? '',
      fullName: (json['fullName'] ?? json['full_name'] ?? json['name'] ?? '')
          .toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? json['phone_number'] ?? '').toString(),
      specialty: json['specialty'] as String?,
      subSpecialty: (json['subSpecialty'] ?? json['sub_specialty']) as String?,
      yearsOfExperience:
          (json['yearsOfExperience'] ??
                  json['years_of_experience'] ??
                  json['experience_years'])
              ?.toString(),
      about: (json['about'] ?? json['bio'] ?? json['description']) as String?,
      education: json['education'] as String?,
      imageUrl:
          (json['imageUrl'] ??
                  json['image_url'] ??
                  json['avatar'] ??
                  json['image'] ??
                  json['profile_picture'])
              as String?,
      isPro:
          json['isPro'] == true ||
          json['is_pro'] == true ||
          json['is_pro'] == 1,
      clinics:
          (json['clinics'] as List<dynamic>?)
              ?.whereType<Map<String, dynamic>>()
              .map((e) => ClinicModel.fromJson(e))
              .toList() ??
          [],
      services:
          (json['services'] as List<dynamic>?)
              ?.whereType<Map<String, dynamic>>()
              .map((e) => ServicePricingModel.fromJson(e))
              .toList() ??
          [],
      paymentDetails: paymentMap != null
          ? PaymentDetailsModel.fromJson(paymentMap)
          : const PaymentDetailsModel(paymentType: 'bank_transfer'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'specialty': specialty,
      'subSpecialty': subSpecialty,
      'yearsOfExperience': yearsOfExperience,
      'about': about,
      'education': education,
      'imageUrl': imageUrl,
      'isPro': isPro,
      'clinics': clinics.map((e) => e.toJson()).toList(),
      'services': services.map((e) => e.toJson()).toList(),
      'paymentDetails': paymentDetails.toJson(),
    };
  }

  ProfileModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? specialty,
    String? subSpecialty,
    String? yearsOfExperience,
    String? about,
    String? education,
    String? imageUrl,
    bool? isPro,
    List<ClinicModel>? clinics,
    List<ServicePricingModel>? services,
    PaymentDetailsModel? paymentDetails,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      specialty: specialty ?? this.specialty,
      subSpecialty: subSpecialty ?? this.subSpecialty,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      about: about ?? this.about,
      education: education ?? this.education,
      imageUrl: imageUrl ?? this.imageUrl,
      isPro: isPro ?? this.isPro,
      clinics: clinics ?? this.clinics,
      services: services ?? this.services,
      paymentDetails: paymentDetails ?? this.paymentDetails,
    );
  }
}
