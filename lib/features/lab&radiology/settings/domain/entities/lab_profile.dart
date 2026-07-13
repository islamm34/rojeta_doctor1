import 'package:equatable/equatable.dart';

class LabProfile extends Equatable {
  final String labName;
  final String licenseNo;
  final int branchesCount;
  final int scansCount;
  final String iconUrl;

  const LabProfile({
    required this.labName,
    required this.licenseNo,
    required this.branchesCount,
    required this.scansCount,
    required this.iconUrl,
  });

  @override
  List<Object?> get props => [labName, licenseNo, branchesCount, scansCount, iconUrl];
}
