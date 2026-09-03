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
    return ProfileModel(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      specialty: json['specialty'] as String?,
      subSpecialty: json['subSpecialty'] as String?,
      yearsOfExperience: json['yearsOfExperience']?.toString(),
      about: json['about'] as String?,
      education: json['education'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isPro: json['isPro'] as bool? ?? false,
      clinics:
          (json['clinics'] as List<dynamic>?)
              ?.map((e) => ClinicModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      services:
          (json['services'] as List<dynamic>?)
              ?.map(
                (e) => ServicePricingModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      paymentDetails: json['paymentDetails'] is Map<String, dynamic>
          ? PaymentDetailsModel.fromJson(
              json['paymentDetails'] as Map<String, dynamic>,
            )
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
