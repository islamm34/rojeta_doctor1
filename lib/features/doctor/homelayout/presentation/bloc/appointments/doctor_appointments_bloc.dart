import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/error/exceptions.dart';
import '../../../data/repositories/doctor_appointments_repository.dart';
import 'doctor_appointments_event.dart';
import 'doctor_appointments_state.dart';

class DoctorAppointmentsBloc
    extends Bloc<DoctorAppointmentsEvent, DoctorAppointmentsState> {
  final DoctorAppointmentsRepository repository;

  DoctorAppointmentsBloc({required this.repository})
      : super(const DoctorAppointmentsState()) {
    on<FetchAppointmentsEvent>(_onFetchAppointments);
    on<FilterAppointmentsByStatusEvent>(_onFilterByStatus);
    on<UpdateAppointmentStatusEvent>(_onUpdateStatus);
  }

  Future<void> _onFetchAppointments(
    FetchAppointmentsEvent event,
    Emitter<DoctorAppointmentsState> emit,
  ) async {
    emit(state.copyWith(
      status: DoctorAppointmentsStatus.loading,
      errorMessage: null,
    ));
    try {
      final appointments = await repository.getAppointments(
        status: event.status,
        date: event.date,
        type: event.type,
        page: event.page,
        limit: event.limit,
      );
      emit(state.copyWith(
        status: DoctorAppointmentsStatus.success,
        appointments: appointments,
      ));
    } catch (e) {
      final errorMessage = e is ServerException
          ? e.message
          : (e is NetworkException ? e.message : e.toString());
      emit(state.copyWith(
        status: DoctorAppointmentsStatus.failure,
        errorMessage: errorMessage,
      ));
    }
  }

  void _onFilterByStatus(
    FilterAppointmentsByStatusEvent event,
    Emitter<DoctorAppointmentsState> emit,
  ) {
    emit(state.copyWith(selectedFilter: event.status));
  }

  Future<void> _onUpdateStatus(
    UpdateAppointmentStatusEvent event,
    Emitter<DoctorAppointmentsState> emit,
  ) async {
    emit(state.copyWith(isUpdatingStatus: true));
    try {
      await repository.updateAppointmentStatus(
        appointmentId: event.appointmentId,
        status: event.status,
      );

      final updated = state.appointments.map((a) {
        if (a.id == event.appointmentId) {
          return a.copyWith(status: event.status);
        }
        return a;
      }).toList();

      emit(state.copyWith(
        isUpdatingStatus: false,
        appointments: updated,
      ));
    } catch (e) {
      final errorMessage = e is ServerException
          ? e.message
          : (e is NetworkException ? e.message : e.toString());
      emit(state.copyWith(
        isUpdatingStatus: false,
        errorMessage: errorMessage,
      ));
    }
  }
}
