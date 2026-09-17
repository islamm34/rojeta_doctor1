import 'package:equatable/equatable.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';

import '../../../data/models/create_lab_service_model.dart';

abstract class LabServicesEvent extends Equatable {
  const LabServicesEvent();

  @override
  List<Object?> get props => [];
}

class FetchLabServicesEvent extends LabServicesEvent {
  final UserType userType;

  const FetchLabServicesEvent(this.userType);

  @override
  List<Object?> get props => [userType];
}

class CreateLabServiceEvent extends LabServicesEvent {
  final CreateLabServiceModel service;
  final UserType userType;

  const CreateLabServiceEvent(this.service, this.userType);

  @override
  List<Object?> get props => [service, userType];
}

class UpdateLabServiceEvent extends LabServicesEvent {
  final String serviceId;
  final CreateLabServiceModel service;
  final UserType userType;

  const UpdateLabServiceEvent(this.serviceId, this.service, this.userType);

  @override
  List<Object?> get props => [serviceId, service, userType];
}

class DeleteLabServiceEvent extends LabServicesEvent {
  final String serviceId;
  final UserType userType;

  const DeleteLabServiceEvent(this.serviceId, this.userType);

  @override
  List<Object?> get props => [serviceId, userType];
}
