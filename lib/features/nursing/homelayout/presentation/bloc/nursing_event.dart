import 'package:equatable/equatable.dart';
import '../../data/models/nursing_service_model.dart';
import '../../data/models/nursing_staff_model.dart';
import '../../data/models/nursing_profile_model.dart';

abstract class NursingEvent extends Equatable {
  const NursingEvent();

  @override
  List<Object?> get props => [];
}

class LoadNursingDashboardData extends NursingEvent {}

class LoadNursingServices extends NursingEvent {}

class AddNursingServiceEvent extends NursingEvent {
  final NursingServiceModel service;

  const AddNursingServiceEvent(this.service);

  @override
  List<Object?> get props => [service];
}

class ChangeNursingTabEvent extends NursingEvent {
  final int index;

  const ChangeNursingTabEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class LoadNursingStaffEvent extends NursingEvent {}

class AddNursingStaffEvent extends NursingEvent {
  final NursingStaffModel staff;

  const AddNursingStaffEvent(this.staff);

  @override
  List<Object?> get props => [staff];
}

class UpdateNursingStaffEvent extends NursingEvent {
  final NursingStaffModel staff;

  const UpdateNursingStaffEvent(this.staff);

  @override
  List<Object?> get props => [staff];
}

class DeleteNursingStaffEvent extends NursingEvent {
  final String staffId;

  const DeleteNursingStaffEvent(this.staffId);

  @override
  List<Object?> get props => [staffId];
}

class DeleteNursingServiceEvent extends NursingEvent {
  final String serviceId;

  const DeleteNursingServiceEvent(this.serviceId);

  @override
  List<Object?> get props => [serviceId];
}

class LoadNursingProfileEvent extends NursingEvent {}

class UpdateNursingOfficeInfoEvent extends NursingEvent {
  final NursingOfficeInfoModel officeInfo;

  const UpdateNursingOfficeInfoEvent(this.officeInfo);

  @override
  List<Object?> get props => [officeInfo];
}

class UpdateNursingWorkingHoursEvent extends NursingEvent {
  final NursingWorkingHoursModel workingHours;

  const UpdateNursingWorkingHoursEvent(this.workingHours);

  @override
  List<Object?> get props => [workingHours];
}

class UpdateNursingSettingsEvent extends NursingEvent {
  final NursingSettingsModel settings;

  const UpdateNursingSettingsEvent(this.settings);

  @override
  List<Object?> get props => [settings];
}

class LoadNursingCoverageAreasEvent extends NursingEvent {}

class AddNursingCoverageAreaEvent extends NursingEvent {
  final NursingCoverageAreaModel area;

  const AddNursingCoverageAreaEvent(this.area);

  @override
  List<Object?> get props => [area];
}

class DeleteNursingCoverageAreaEvent extends NursingEvent {
  final String areaId;

  const DeleteNursingCoverageAreaEvent(this.areaId);

  @override
  List<Object?> get props => [areaId];
}

class ToggleNursingCoverageAreaEvent extends NursingEvent {
  final String areaId;
  final bool isActive;

  const ToggleNursingCoverageAreaEvent({required this.areaId, required this.isActive});

  @override
  List<Object?> get props => [areaId, isActive];
}

class LoadNursingDocumentsEvent extends NursingEvent {}

class UploadNursingDocumentEvent extends NursingEvent {
  final String documentType;
  final String filePath;

  const UploadNursingDocumentEvent({
    required this.documentType,
    required this.filePath,
  });

  @override
  List<Object?> get props => [documentType, filePath];
}

class DeleteNursingDocumentEvent extends NursingEvent {
  final String documentId;

  const DeleteNursingDocumentEvent(this.documentId);

  @override
  List<Object?> get props => [documentId];
}

class LoadNursingPaymentSettingsEvent extends NursingEvent {}

class UpdateNursingPaymentSettingsEvent extends NursingEvent {
  final NursingPaymentSettingsModel paymentSettings;

  const UpdateNursingPaymentSettingsEvent(this.paymentSettings);

  @override
  List<Object?> get props => [paymentSettings];
}


