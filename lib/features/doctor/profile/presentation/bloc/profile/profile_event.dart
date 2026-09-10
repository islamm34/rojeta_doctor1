import 'package:equatable/equatable.dart';
import 'package:rojeta_doctor/features/doctor/profile/data/models/clinic_model.dart';
import 'package:rojeta_doctor/features/doctor/profile/data/models/payment_details_model.dart';
import 'package:rojeta_doctor/features/doctor/profile/data/models/settings_model.dart';

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

class SaveServicesEvent extends ProfileEvent {
  const SaveServicesEvent();
}

class SwitchPaymentTypeEvent extends ProfileEvent {
  final String type;

  const SwitchPaymentTypeEvent(this.type);

  @override
  List<Object?> get props => [type];
}

class SavePaymentDetailsEvent extends ProfileEvent {
  final PaymentDetailsModel paymentDetails;

  const SavePaymentDetailsEvent(this.paymentDetails);

  @override
  List<Object?> get props => [paymentDetails];
}

class DeleteClinicEvent extends ProfileEvent {
  final String clinicId;

  const DeleteClinicEvent(this.clinicId);

  @override
  List<Object?> get props => [clinicId];
}

class AddClinicSubmittedEvent extends ProfileEvent {
  final ClinicModel clinic;

  const AddClinicSubmittedEvent(this.clinic);

  @override
  List<Object?> get props => [clinic];
}

class UpdateClinicSubmittedEvent extends ProfileEvent {
  final ClinicModel clinic;

  const UpdateClinicSubmittedEvent(this.clinic);

  @override
  List<Object?> get props => [clinic];
}

class UpdateProfileDetailsEvent extends ProfileEvent {
  final Map<String, dynamic> data;

  const UpdateProfileDetailsEvent(this.data);

  @override
  List<Object?> get props => [data];
}

class LoadSettingsEvent extends ProfileEvent {
  const LoadSettingsEvent();
}

class ToggleSettingEvent extends ProfileEvent {
  final String settingKey;
  final bool isEnabled;

  const ToggleSettingEvent(this.settingKey, this.isEnabled);

  @override
  List<Object?> get props => [settingKey, isEnabled];
}

class SaveSettingsEvent extends ProfileEvent {
  final SettingsModel settings;

  const SaveSettingsEvent(this.settings);

  @override
  List<Object?> get props => [settings];
}
