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
    return PatientModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      gender: json['gender'] as String? ?? '',
      visitsCount: json['visitsCount'] as int? ?? 0,
      lastVisitDate: json['lastVisitDate'] != null
          ? DateTime.parse(json['lastVisitDate'] as String)
          : DateTime.now(),
      lastDiagnosis: json['lastDiagnosis'] as String? ?? '',
      address: json['address'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
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
