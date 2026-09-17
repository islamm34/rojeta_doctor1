import 'package:equatable/equatable.dart';

class LabProfileModel extends Equatable {
  final String? labName;
  final String? licenseNo;
  final int? branchesCount;
  final int? scansCount;
  final String? iconUrl;

  const LabProfileModel({
    this.labName,
    this.licenseNo,
    this.branchesCount,
    this.scansCount,
    this.iconUrl,
  });

  factory LabProfileModel.fromJson(Map<String, dynamic> json) {
    return LabProfileModel(
      labName: (json['labName'] ?? json['name'] ?? json['lab_name']) as String?,
      licenseNo: (json['licenseNo'] ?? json['license_no'] ?? json['license_number']) as String?,
      branchesCount: (json['branchesCount'] ?? json['branches_count'] ?? json['total_branches']) as int?,
      scansCount: (json['scansCount'] ?? json['scans_count'] ?? json['services_count']) as int?,
      iconUrl: (json['iconUrl'] ?? json['icon_url'] ?? json['image'] ?? json['avatar']) as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lab_name': labName,
      'license_no': licenseNo,
      'branches_count': branchesCount,
      'scans_count': scansCount,
      'icon_url': iconUrl,
    };
  }

  LabProfileModel copyWith({
    String? labName,
    String? licenseNo,
    int? branchesCount,
    int? scansCount,
    String? iconUrl,
  }) {
    return LabProfileModel(
      labName: labName ?? this.labName,
      licenseNo: licenseNo ?? this.licenseNo,
      branchesCount: branchesCount ?? this.branchesCount,
      scansCount: scansCount ?? this.scansCount,
      iconUrl: iconUrl ?? this.iconUrl,
    );
  }

  @override
  List<Object?> get props => [labName, licenseNo, branchesCount, scansCount, iconUrl];
}
