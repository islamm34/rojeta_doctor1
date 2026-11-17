import 'clinic_model.dart';
import 'payment_details_model.dart';
import 'service_pricing_model.dart';

String? _sanitizeImageUrl(dynamic url) {
  if (url == null) return null;
  final s = url.toString().trim();
  if (s.isEmpty) return null;
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
  final String? qrCodeData;
  final List<String> certificates;

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
    this.qrCodeData,
    this.certificates = const [],
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final rawPayment = json['paymentDetails'] ?? json['payment_details'];
    final paymentMap = rawPayment is Map
        ? Map<String, dynamic>.from(rawPayment)
        : null;

    final rawClinics = json['clinics'];
    final List<ClinicModel> clinicsList = [];
    if (rawClinics is List) {
      for (final item in rawClinics) {
        if (item is Map) {
          clinicsList.add(
            ClinicModel.fromJson(Map<String, dynamic>.from(item)),
          );
        }
      }
    }

    final rawServices = json['services'];
    final List<ServicePricingModel> servicesList = [];
    if (rawServices is List) {
      for (final item in rawServices) {
        if (item is Map) {
          servicesList.add(
            ServicePricingModel.fromJson(Map<String, dynamic>.from(item)),
          );
        }
      }
    }

    return ProfileModel(
      id: json['id']?.toString() ?? '',
      fullName: (json['fullName'] ?? json['full_name'] ?? json['name'] ?? '')
          .toString(),
      email: (json['email'] ??
              (json['user'] is Map ? json['user']['email'] : null) ??
              (json['doctor'] is Map ? json['doctor']['email'] : null) ??
              (json['profile'] is Map ? json['profile']['email'] : null) ??
              json['user_email'] ??
              '')
          .toString(),
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
      imageUrl: _sanitizeImageUrl(
        (json['imageUrl'] ??
                json['image_url'] ??
                json['avatar'] ??
                json['image'] ??
                json['profile_picture'])
            as String?,
      ),
      isPro:
          json['isPro'] == true ||
          json['is_pro'] == true ||
          json['is_pro'] == 1 ||
          json['is_pro'] == '1' ||
          json['isPro'] == 1 ||
          json['isPro'] == '1' ||
          json['active_plan'] != null ||
          json['activePlan'] != null ||
          json['subscription'] != null ||
          json['has_active_subscription'] == true,
      clinics: clinicsList,
      services: servicesList,
      paymentDetails: paymentMap != null
          ? PaymentDetailsModel.fromJson(paymentMap)
          : const PaymentDetailsModel(paymentType: 'bank_transfer'),
      qrCodeData: (json['qrCodeData'] ?? json['qr_code_data'] ?? json['qr_data'])?.toString(),
      certificates: (json['certificates'] as List?)?.map((e) => e.toString()).toList() ?? const [],
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
      'qr_code_data': qrCodeData,
      'certificates': certificates,
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
    String? qrCodeData,
    List<String>? certificates,
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
      qrCodeData: qrCodeData ?? this.qrCodeData,
      certificates: certificates ?? this.certificates,
    );
  }
}
