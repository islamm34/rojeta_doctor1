import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../models/patient_details_model.dart';
import '../models/patient_model.dart';

class PatientsRepository {
  final ApiConsumer apiConsumer;

  PatientsRepository({required this.apiConsumer});

  Future<List<PatientModel>> getPatients({
    int? page,
    int? limit,
    String? search,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (page != null) queryParameters['page'] = page;
    if (limit != null) queryParameters['limit'] = limit;
    if (search != null && search.trim().isNotEmpty) {
      queryParameters['search'] = search.trim();
    }

    final response = await apiConsumer.get(
      Endpoints.doctorPatients,
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );

    final rawList = response is Map<String, dynamic> && response['data'] is List
        ? response['data'] as List<dynamic>
        : (response is List ? response : <dynamic>[]);

    return rawList
        .whereType<Map<String, dynamic>>()
        .map((e) => PatientModel.fromJson(e))
        .toList();
  }

  Future<PatientDetailsModel> getPatientDetails(String patientId) async {
    final response = await apiConsumer.get(
      Endpoints.doctorPatientDetails(patientId),
    );

    final data = response is Map<String, dynamic> && response['data'] != null
        ? response['data'] as Map<String, dynamic>
        : (response is Map<String, dynamic> ? response : <String, dynamic>{});

    return PatientDetailsModel.fromJson(data);
  }
}
