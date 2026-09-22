import '../../domain/repositories/i_medical_services_repository.dart';
import '../datasources/medical_services_remote_data_source.dart';
import '../models/hospital_service_model.dart';
import '../models/specialty_model.dart';

class MedicalServicesRepositoryImpl implements IMedicalServicesRepository {
  final MedicalServicesRemoteDataSource remoteDataSource;

  MedicalServicesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<
    ({List<SpecialtyModel> specialties, List<HospitalServiceModel> services})
  >
  getMedicalServices() async {
    return await remoteDataSource.getMedicalServices();
  }

  @override
  Future<void> toggleService(String serviceId, bool isEnabled) async {
    await remoteDataSource.toggleService(serviceId, isEnabled);
  }

  @override
  Future<SpecialtyModel> addSpecialty(SpecialtyModel specialty) async {
    return await remoteDataSource.addSpecialty(specialty);
  }
}
