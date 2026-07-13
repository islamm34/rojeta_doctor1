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

