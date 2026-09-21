import 'package:equatable/equatable.dart';

class PatientModel extends Equatable {
  final String id;
  final String name;
  final String phone;
  final int age;
  final String gender;
  final int visitsCount;
  final DateTime lastVisitDate;
  final String lastDiagnosis;
  final String? address;
  final String? bloodGroup;

  const PatientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.age,
    required this.gender,
    required this.visitsCount,
    required this.lastVisitDate,
    required this.lastDiagnosis,
    this.address,
    this.bloodGroup,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate = DateTime.now();
    final rawDate =
        json['lastVisitDate'] ??
        json['last_visit_date'] ??
        json['last_visit_at'] ??
        json['updated_at'] ??
        json['created_at'] ??
        json['date'];
    if (rawDate != null) {
      final parsed = DateTime.tryParse(rawDate.toString());
      if (parsed != null) parsedDate = parsed;
    }

    int parsedAge = 0;
    final rawAge = json['age'];
    if (rawAge is num) {
      parsedAge = rawAge.toInt();
    } else if (rawAge != null) {
      parsedAge = int.tryParse(rawAge.toString()) ?? 0;
    }

    int parsedVisits = 1;
    final rawVisits =
        json['visitsCount'] ??
        json['visits_count'] ??
        json['appointments_count'] ??
        json['total_visits'];
    if (rawVisits is num) {
      parsedVisits = rawVisits.toInt();
    } else if (rawVisits != null) {
      parsedVisits = int.tryParse(rawVisits.toString()) ?? 1;
    }

    String? parsedAddress;
    final rawAddress = json['address'];
    if (rawAddress is Map) {
      parsedAddress =
          (rawAddress['formatted'] ??
                  rawAddress['address'] ??
                  rawAddress.toString())
              .toString();
    } else if (rawAddress != null) {
      parsedAddress = rawAddress.toString();
    }

    return PatientModel(
      id: (json['id'] ?? json['patient_id'] ?? json['user_id'] ?? '')
          .toString(),
      name: (json['name'] ?? json['patient_name'] ?? json['full_name'] ?? '')
          .toString(),
      phone: (json['phone'] ?? json['phone_number'] ?? json['mobile'] ?? '')
          .toString(),
      age: parsedAge,
      gender: (json['gender'] ?? json['sex'] ?? '').toString(),
      visitsCount: parsedVisits,
      lastVisitDate: parsedDate,
      lastDiagnosis:
          (json['lastDiagnosis'] ??
                  json['last_diagnosis'] ??
                  json['diagnosis'] ??
                  '')
              .toString(),
      address: parsedAddress,
      bloodGroup: (json['bloodGroup'] ?? json['blood_group'])?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'age': age,
      'gender': gender,
      'visitsCount': visitsCount,
      'lastVisitDate': lastVisitDate.toIso8601String(),
      'lastDiagnosis': lastDiagnosis,
      if (address != null) 'address': address,
      if (bloodGroup != null) 'bloodGroup': bloodGroup,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    phone,
    age,
    gender,
    visitsCount,
    lastVisitDate,
    lastDiagnosis,
    address,
    bloodGroup,
  ];
}
