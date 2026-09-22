import '../../data/models/hospital_service_model.dart';
import '../../data/models/specialty_model.dart';

abstract class IMedicalServicesRepository {
  Future<
    ({List<SpecialtyModel> specialties, List<HospitalServiceModel> services})
  >
  getMedicalServices();
  Future<void> toggleService(String serviceId, bool isEnabled);
  Future<SpecialtyModel> addSpecialty(SpecialtyModel specialty);
}
