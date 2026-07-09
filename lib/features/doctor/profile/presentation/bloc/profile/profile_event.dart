import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfileEvent extends ProfileEvent {
  const LoadProfileEvent();
}

class SwitchTabEvent extends ProfileEvent {
  final bool isProfile;

  const SwitchTabEvent(this.isProfile);

  @override
  List<Object?> get props => [isProfile];
}

class ToggleServiceEvent extends ProfileEvent {
  final String serviceId;
  final bool isEnabled;

  const ToggleServiceEvent(this.serviceId, this.isEnabled);

  @override
  List<Object?> get props => [serviceId, isEnabled];
}

class UpdateServicePriceEvent extends ProfileEvent {
  final String serviceId;
  final double newPrice;

  const UpdateServicePriceEvent(this.serviceId, this.newPrice);

  @override
  List<Object?> get props => [serviceId, newPrice];
}

class SwitchPaymentTypeEvent extends ProfileEvent {
  final String type;

  const SwitchPaymentTypeEvent(this.type);

  @override
  List<Object?> get props => [type];
}

class DeleteClinicEvent extends ProfileEvent {
  final String clinicId;

  const DeleteClinicEvent(this.clinicId);

  @override
  List<Object?> get props => [clinicId];
}

class ToggleSettingEvent extends ProfileEvent {
  final String settingKey;
  final bool isEnabled;

  const ToggleSettingEvent(this.settingKey, this.isEnabled);

  @override
  List<Object?> get props => [settingKey, isEnabled];
}
