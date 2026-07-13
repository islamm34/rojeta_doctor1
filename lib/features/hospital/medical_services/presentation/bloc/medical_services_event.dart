abstract class MedicalServicesEvent {}

class FetchMedicalServicesEvent extends MedicalServicesEvent {}

class ToggleServiceEvent extends MedicalServicesEvent {
  final String serviceId;
  ToggleServiceEvent(this.serviceId);
}

class AddSpecialtyEvent extends MedicalServicesEvent {
  final String name;
  final String description;
  final bool hasEmergency;

  AddSpecialtyEvent({
    required this.name,
    required this.description,
    required this.hasEmergency,
  });
}
