import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/patients_repository.dart';
import 'patients_event.dart';
import 'patients_state.dart';

class PatientsBloc extends Bloc<PatientsEvent, PatientsState> {
  final PatientsRepository _repository;

  PatientsBloc(this._repository) : super(const PatientsState()) {
    on<FetchPatientsEvent>(_onFetchPatients);
    on<FetchPatientDetailsEvent>(_onFetchPatientDetails);
  }

  Future<void> _onFetchPatients(
    FetchPatientsEvent event,
    Emitter<PatientsState> emit,
  ) async {
    emit(state.copyWith(status: PatientsStatus.loading, errorMessage: null));
    try {
      final patients = await _repository.getPatients();
      emit(state.copyWith(status: PatientsStatus.success, patients: patients));
    } catch (e) {
      emit(state.copyWith(
        status: PatientsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onFetchPatientDetails(
    FetchPatientDetailsEvent event,
    Emitter<PatientsState> emit,
  ) async {
    emit(state.copyWith(status: PatientsStatus.loading, errorMessage: null));
    try {
      final details = await _repository.getPatientDetails(event.patientId);
      emit(state.copyWith(status: PatientsStatus.success, selectedPatient: details));
    } catch (e) {
      emit(state.copyWith(
        status: PatientsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
