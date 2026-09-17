import 'package:equatable/equatable.dart';
import 'package:rojeta_doctor/features/auth/data/models/user_type_model.dart';

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

class DeleteLabServiceEvent extends LabServicesEvent {
  final String serviceId;
  final UserType userType;

  const DeleteLabServiceEvent(this.serviceId, this.userType);

  @override
  List<Object?> get props => [serviceId, userType];
}
