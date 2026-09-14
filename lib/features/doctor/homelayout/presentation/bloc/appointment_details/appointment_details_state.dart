import 'package:equatable/equatable.dart';

import '../../../data/models/doctor_appointment_details_model.dart';

enum AppointmentDetailsStatus { initial, loading, success, failure }

class AppointmentDetailsState extends Equatable {
  final AppointmentDetailsStatus status;
  final DoctorAppointmentDetailsModel? appointmentDetails;
  final String? errorMessage;

  const AppointmentDetailsState({
    this.status = AppointmentDetailsStatus.initial,
    this.appointmentDetails,
    this.errorMessage,
  });

  AppointmentDetailsState copyWith({
    AppointmentDetailsStatus? status,
    DoctorAppointmentDetailsModel? appointmentDetails,
    String? errorMessage,
  }) {
    return AppointmentDetailsState(
      status: status ?? this.status,
      appointmentDetails: appointmentDetails ?? this.appointmentDetails,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, appointmentDetails, errorMessage];
}
