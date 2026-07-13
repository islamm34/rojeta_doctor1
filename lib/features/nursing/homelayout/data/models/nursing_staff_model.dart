class NursingStaffModel {
  final String id;
  final String name;
  final String imageUrl;
  final String gender;
  final String status;
  final List<String> skills;
  final int yearsOfExperience;

  NursingStaffModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.gender,
    required this.status,
    required this.skills,
    required this.yearsOfExperience,
  });

  factory NursingStaffModel.fromJson(Map<String, dynamic> json) {
    return NursingStaffModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      gender: json['gender'] as String,
      status: json['status'] as String,
      skills: (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      yearsOfExperience: json['yearsOfExperience'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'gender': gender,
      'status': status,
      'skills': skills,
      'yearsOfExperience': yearsOfExperience,
    };
  }
}

class NursingStaffStatsModel {
  final int totalStaff;
  final int available;
  final int onDuty;
  final int onLeave;

  NursingStaffStatsModel({
    required this.totalStaff,
    required this.available,
    required this.onDuty,
    required this.onLeave,
  });

  factory NursingStaffStatsModel.fromJson(Map<String, dynamic> json) {
    return NursingStaffStatsModel(
      totalStaff: json['totalStaff'] as int,
      available: json['available'] as int,
      onDuty: json['onDuty'] as int,
      onLeave: json['onLeave'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalStaff': totalStaff,
      'available': available,
      'onDuty': onDuty,
      'onLeave': onLeave,
    };
  }
}
