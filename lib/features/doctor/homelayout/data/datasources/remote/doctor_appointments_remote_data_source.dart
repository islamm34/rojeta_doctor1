import '../../../../../../core/local/user_hive_helper.dart';
import '../../../../../../core/network/api_consumer.dart';
import '../../../../../../core/network/endpoints.dart';
import '../../models/doctor_appointment_details_model.dart';
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

  Future<DoctorAppointmentDetailsModel> getAppointmentDetails(
    String appointmentId,
  );

  Future<void> confirmCashPayment({
    required String appointmentId,
    double? amountPaid,
  });
}

class DoctorAppointmentsRemoteDataSourceImpl
    implements DoctorAppointmentsRemoteDataSource {
  final ApiConsumer apiConsumer;

  DoctorAppointmentsRemoteDataSourceImpl({required this.apiConsumer});

  bool get _isHospitalRole {
    final role = UserHiveHelper.getUser()?.role?.toLowerCase().trim() ?? '';
    return role == 'hospital' || role.contains('hospital');
  }

  String get _appointmentsEndpoint => _isHospitalRole
      ? Endpoints.hospitalAppointments
      : Endpoints.doctorAppointments;

  String _appointmentStatusEndpoint(String appointmentId) => _isHospitalRole
      ? Endpoints.hospitalAppointmentStatus(appointmentId)
      : Endpoints.doctorAppointmentStatus(appointmentId);

  String _appointmentConfirmCashPaymentEndpoint(String appointmentId) =>
      _isHospitalRole
      ? Endpoints.hospitalAppointmentConfirmCashPayment(appointmentId)
      : Endpoints.doctorAppointmentConfirmCashPayment(appointmentId);

  String _appointmentDetailsEndpoint(String appointmentId) => _isHospitalRole
      ? Endpoints.hospitalAppointmentDetails(appointmentId)
      : Endpoints.doctorAppointmentDetails(appointmentId);

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
      _appointmentsEndpoint,
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
      } else if (response['data'] is Map<String, dynamic> &&
          response['data']['appointments'] is List) {
        rawList = response['data']['appointments'] as List<dynamic>;
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
      _appointmentStatusEndpoint(appointmentId),
      data: {'status': status},
    );
  }

  @override
  Future<void> confirmCashPayment({
    required String appointmentId,
    double? amountPaid,
  }) async {
    try {
      await apiConsumer.post(
        _appointmentConfirmCashPaymentEndpoint(appointmentId),
        data: {
          'appointment_id': appointmentId,
          'payment_method': 'cash',
          'payment_status': 'paid',
          'amount_paid': ?amountPaid,
        },
      );
    } catch (_) {
      // Fallback: update status to paid / completed
      await apiConsumer.patch(
        _appointmentStatusEndpoint(appointmentId),
        data: {'status': 'confirmed', 'payment_status': 'paid'},
      );
    }
  }

  @override
  Future<DoctorAppointmentDetailsModel> getAppointmentDetails(
    String appointmentId,
  ) async {
    final response = await apiConsumer.get(
      _appointmentDetailsEndpoint(appointmentId),
    );

    if (response is Map<String, dynamic>) {
      Map<String, dynamic> data = response;
      if (response['data'] is Map<String, dynamic>) {
        final nestedData = response['data'] as Map<String, dynamic>;
        if (nestedData['appointment'] is Map<String, dynamic>) {
          data = nestedData['appointment'] as Map<String, dynamic>;
        } else if (nestedData['booking'] is Map<String, dynamic>) {
          data = nestedData['booking'] as Map<String, dynamic>;
        } else {
          data = nestedData;
        }
      } else if (response['appointment'] is Map<String, dynamic>) {
        data = response['appointment'] as Map<String, dynamic>;
      }
      return DoctorAppointmentDetailsModel.fromJson(data);
    }

    throw const FormatException('Invalid appointment details response format');
  }
}
