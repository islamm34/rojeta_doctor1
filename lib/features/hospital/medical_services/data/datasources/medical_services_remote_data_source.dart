import '../../../../../../core/network/api_consumer.dart';
import '../mocks/medical_services_mock_data.dart';
import '../models/hospital_service_model.dart';
import '../models/specialty_model.dart';

abstract class MedicalServicesRemoteDataSource {
  Future<
    ({List<SpecialtyModel> specialties, List<HospitalServiceModel> services})
  >
  getMedicalServices();
  Future<void> toggleService(String serviceId, bool isEnabled);
  Future<SpecialtyModel> addSpecialty(SpecialtyModel specialty);
}

class MedicalServicesRemoteDataSourceImpl
    implements MedicalServicesRemoteDataSource {
  final ApiConsumer apiConsumer;

  MedicalServicesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<
    ({List<SpecialtyModel> specialties, List<HospitalServiceModel> services})
  >
  getMedicalServices() async {
    try {
      final response = await apiConsumer.get('/hospital/services');
      if (response is Map<String, dynamic>) {
        final data = response['data'] is Map<String, dynamic>
            ? response['data'] as Map<String, dynamic>
            : response;

        final specialtiesRaw = data['specialties'] ?? [];
        final servicesRaw = data['services'] ?? [];

        List<SpecialtyModel> specialties = [];
        if (specialtiesRaw is List) {
          specialties = specialtiesRaw
              .whereType<Map<String, dynamic>>()
              .map((e) => SpecialtyModel.fromJson(e))
              .toList();
        }

        List<HospitalServiceModel> services = [];
        if (servicesRaw is List) {
          services = servicesRaw
              .whereType<Map<String, dynamic>>()
              .map((e) => HospitalServiceModel.fromJson(e))
              .toList();
        }

        if (services.isEmpty) {
          services = MedicalServicesMockData.initialServices;
        }

        return (specialties: specialties, services: services);
      }
    } catch (_) {}

    return (
      specialties: MedicalServicesMockData.emptySpecialties,
      services: MedicalServicesMockData.initialServices,
    );
  }

  @override
  Future<void> toggleService(String serviceId, bool isEnabled) async {
    try {
      await apiConsumer.put(
        '/hospital/services/$serviceId/toggle',
        data: {'is_enabled': isEnabled},
      );
    } catch (_) {}
  }

  @override
  Future<SpecialtyModel> addSpecialty(SpecialtyModel specialty) async {
    try {
      final response = await apiConsumer.post(
        '/hospital/specialties/add',
        data: specialty.toJson(),
      );
      if (response is Map<String, dynamic>) {
        final data = response['data'] is Map<String, dynamic>
            ? response['data'] as Map<String, dynamic>
            : response;
        return SpecialtyModel.fromJson(data);
      }
    } catch (_) {}

    return specialty;
  }
}
