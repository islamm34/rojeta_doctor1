import '../../domain/entities/lab_profile.dart';

class LabProfileModel extends LabProfile {
  const LabProfileModel({
    required super.labName,
    required super.licenseNo,
    required super.branchesCount,
    required super.scansCount,
    required super.iconUrl,
  });

  factory LabProfileModel.fromJson(Map<String, dynamic> json) {
    return LabProfileModel(
      labName: json['labName'] as String? ?? '',
      licenseNo: json['licenseNo'] as String? ?? '',
      branchesCount: json['branchesCount'] as int? ?? 0,
      scansCount: json['scansCount'] as int? ?? 0,
      iconUrl: json['iconUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'labName': labName,
      'licenseNo': licenseNo,
      'branchesCount': branchesCount,
      'scansCount': scansCount,
      'iconUrl': iconUrl,
    };
  }
}
