import '../../../../../../core/local/user_hive_helper.dart';
import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../models/doctor_appointment_model.dart';
import '../models/patient_details_model.dart';

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

    List<dynamic> rawList = [];
    try {
      final response = await apiConsumer.get(
        Endpoints.doctorPatients,
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );

      if (response is List) {
        rawList = response;
      } else if (response is Map<String, dynamic>) {
        if (response['data'] is List) {
          rawList = response['data'] as List<dynamic>;
        } else if (response['data'] is Map<String, dynamic>) {
          final dataMap = response['data'] as Map<String, dynamic>;
          if (dataMap['patients'] is List) {
            rawList = dataMap['patients'] as List<dynamic>;
          } else if (dataMap['data'] is List) {
            rawList = dataMap['data'] as List<dynamic>;
          } else if (dataMap['items'] is List) {
            rawList = dataMap['items'] as List<dynamic>;
          }
        } else if (response['patients'] is List) {
          rawList = response['patients'] as List<dynamic>;
        }
      }
    } catch (_) {}

    final List<PatientModel> parsedPatients = rawList
        .whereType<Map<String, dynamic>>()
        .map((e) => PatientModel.fromJson(e))
        .toList();

    // If patients endpoint returns empty, synthesize from appointments
    if (parsedPatients.isEmpty) {
      try {
        final role = UserHiveHelper.getUser()?.role?.toLowerCase().trim() ?? '';
        final endpoint = (role == 'hospital' || role.contains('hospital'))
            ? Endpoints.hospitalAppointments
            : Endpoints.doctorAppointments;
        final apptResponse = await apiConsumer.get(endpoint);
        List<dynamic> apptList = [];
        if (apptResponse is List) {
          apptList = apptResponse;
        } else if (apptResponse is Map<String, dynamic>) {
          if (apptResponse['data'] is List) {
            apptList = apptResponse['data'] as List<dynamic>;
          } else if (apptResponse['data'] is Map<String, dynamic> &&
              apptResponse['data']['data'] is List) {
            apptList = apptResponse['data']['data'] as List<dynamic>;
          } else if (apptResponse['appointments'] is List) {
            apptList = apptResponse['appointments'] as List<dynamic>;
          } else if (apptResponse['bookings'] is List) {
            apptList = apptResponse['bookings'] as List<dynamic>;
          }
        }

        final Map<String, PatientModel> uniquePatients = {};
        for (final item in apptList) {
          if (item is Map<String, dynamic>) {
            final appt = DoctorAppointmentModel.fromJson(item);
            final pId = appt.patientId ?? appt.id;
            if (!uniquePatients.containsKey(pId) &&
                appt.patientName.isNotEmpty) {
              DateTime apptDate = DateTime.now();
              if (appt.appointmentDate.isNotEmpty) {
                final d = DateTime.tryParse(appt.appointmentDate);
                if (d != null) apptDate = d;
              }
              uniquePatients[pId] = PatientModel(
                id: pId,
                name: appt.patientName,
                phone: appt.patientPhone ?? '',
                age: int.tryParse(appt.patientAge) ?? 0,
                gender: appt.patientGender,
                visitsCount: 1,
                lastVisitDate: apptDate,
                lastDiagnosis: appt.type,
                address: appt.location,
              );
            }
          }
        }
        parsedPatients.addAll(uniquePatients.values);
      } catch (_) {}
    }

    if (search != null && search.trim().isNotEmpty) {
      final q = search.trim().toLowerCase();
      return parsedPatients
          .where(
            (p) =>
                p.name.toLowerCase().contains(q) ||
                p.phone.toLowerCase().contains(q),
          )
          .toList();
    }

    return parsedPatients;
  }

  Future<PatientDetailsModel> getPatientDetails(String patientId) async {
    try {
      final response = await apiConsumer.get(
        Endpoints.doctorPatientDetails(patientId),
      );

      final data = response is Map<String, dynamic> && response['data'] != null
          ? (response['data'] is Map<String, dynamic>
                ? response['data'] as Map<String, dynamic>
                : response)
          : (response is Map<String, dynamic> ? response : <String, dynamic>{});

      return PatientDetailsModel.fromJson(data);
    } catch (_) {
      // Fallback: look up in patients or appointments list
      final allPatients = await getPatients();
      final found = allPatients.firstWhere(
        (p) => p.id == patientId,
        orElse: () => PatientModel(
          id: patientId,
          name: '',
          phone: '',
          age: 0,
          gender: '',
          visitsCount: 1,
          lastVisitDate: DateTime.now(),
          lastDiagnosis: '',
        ),
      );
      return PatientDetailsModel(
        basicInfo: found,
        allergies: const [],
        chronicConditions: const [],
        visitHistory: const [],
        labResults: const [],
      );
    }
  }
}
