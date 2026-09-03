import 'package:equatable/equatable.dart';

abstract class DoctorAppointmentsEvent extends Equatable {
  const DoctorAppointmentsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAppointmentsEvent extends DoctorAppointmentsEvent {
  final String? status;
  final String? date;
  final String? type;
  final int? page;
  final int? limit;

  const FetchAppointmentsEvent({
    this.status,
    this.date,
    this.type,
    this.page,
    this.limit,
  });

  @override
  List<Object?> get props => [status, date, type, page, limit];
}

class FilterAppointmentsByStatusEvent extends DoctorAppointmentsEvent {
  final String status;

  const FilterAppointmentsByStatusEvent(this.status);

  @override
  List<Object?> get props => [status];
}

class UpdateAppointmentStatusEvent extends DoctorAppointmentsEvent {
  final String appointmentId;
  final String status;

  const UpdateAppointmentStatusEvent({
    required this.appointmentId,
    required this.status,
  });

  @override
  List<Object?> get props => [appointmentId, status];
}
