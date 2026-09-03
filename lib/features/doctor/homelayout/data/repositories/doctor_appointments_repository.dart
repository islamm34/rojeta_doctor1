import '../datasources/remote/doctor_appointments_remote_data_source.dart';
import '../models/doctor_appointment_model.dart';

abstract class DoctorAppointmentsRepository {
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

class DoctorAppointmentsRepositoryImpl implements DoctorAppointmentsRepository {
  final DoctorAppointmentsRemoteDataSource remoteDataSource;

  DoctorAppointmentsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<DoctorAppointmentModel>> getAppointments({
    int? page,
    int? limit,
    String? date,
    String? status,
    String? type,
  }) =>
      remoteDataSource.getAppointments(
        page: page,
        limit: limit,
        date: date,
        status: status,
        type: type,
      );

  @override
  Future<void> updateAppointmentStatus({
    required String appointmentId,
    required String status,
  }) =>
      remoteDataSource.updateAppointmentStatus(
        appointmentId: appointmentId,
        status: status,
      );
}
