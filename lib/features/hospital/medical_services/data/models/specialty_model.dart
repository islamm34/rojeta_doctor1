import 'staff_model.dart';

class SpecialtyModel {
  final String id;
  final String name;
  final String description;
  final bool hasEmergency;
  final int doctorsCount;
  final int nursesCount;
  final List<StaffModel> staffList;

  SpecialtyModel({
    required this.id,
    required this.name,
    required this.description,
    required this.hasEmergency,
    required this.doctorsCount,
    required this.nursesCount,
    required this.staffList,
  });

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      hasEmergency: json['hasEmergency'] as bool,
      doctorsCount: json['doctorsCount'] as int,
      nursesCount: json['nursesCount'] as int,
      staffList:
          (json['staffList'] as List<dynamic>?)
              ?.map((e) => StaffModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'hasEmergency': hasEmergency,
      'doctorsCount': doctorsCount,
      'nursesCount': nursesCount,
      'staffList': staffList.map((e) => e.toJson()).toList(),
    };
  }

  SpecialtyModel copyWith({
    String? id,
    String? name,
    String? description,
    bool? hasEmergency,
    int? doctorsCount,
    int? nursesCount,
    List<StaffModel>? staffList,
  }) {
    return SpecialtyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      hasEmergency: hasEmergency ?? this.hasEmergency,
      doctorsCount: doctorsCount ?? this.doctorsCount,
      nursesCount: nursesCount ?? this.nursesCount,
      staffList: staffList ?? this.staffList,
    );
  }
}
