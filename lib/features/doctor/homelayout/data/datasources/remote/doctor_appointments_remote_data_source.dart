import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../../models/doctor_appointment_model.dart';

abstract class DoctorAppointmentsRemoteDataSource {
  Future<List<DoctorAppointmentModel>> getAppointments({
    int? page,
    int? limit,
    String? date,
    String? status,
    String? type,
  });

  Future<void> updateAppointmentStatus({
    required String appointmentId,
    required String status,
  });
}

class DoctorAppointmentsRemoteDataSourceImpl
    implements DoctorAppointmentsRemoteDataSource {
  final ApiConsumer apiConsumer;

  DoctorAppointmentsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<DoctorAppointmentModel>> getAppointments({
    int? page,
    int? limit,
    String? date,
    String? status,
    String? type,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (page != null) queryParameters['page'] = page;
    if (limit != null) queryParameters['limit'] = limit;
    if (date != null && date.isNotEmpty) queryParameters['date'] = date;
    if (status != null && status.isNotEmpty && status.toLowerCase() != 'all') {
      queryParameters['status'] = status;
    }
    if (type != null && type.isNotEmpty) queryParameters['type'] = type;

    final response = await apiConsumer.get(
      Endpoints.doctorAppointments,
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );

    List<dynamic> rawList = [];
    if (response is List) {
      rawList = response;
    } else if (response is Map<String, dynamic>) {
      if (response['data'] is List) {
        rawList = response['data'] as List<dynamic>;
      } else if (response['data'] is Map<String, dynamic> &&
          response['data']['data'] is List) {
        rawList = response['data']['data'] as List<dynamic>;
      } else if (response['appointments'] is List) {
        rawList = response['appointments'] as List<dynamic>;
      } else if (response['bookings'] is List) {
        rawList = response['bookings'] as List<dynamic>;
      }
    }

    return rawList
        .whereType<Map<String, dynamic>>()
        .map((e) => DoctorAppointmentModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> updateAppointmentStatus({
    required String appointmentId,
    required String status,
  }) async {
    await apiConsumer.patch(
      Endpoints.doctorAppointmentStatus(appointmentId),
      data: {'status': status},
    );
  }
}
