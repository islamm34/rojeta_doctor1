import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/medical_consultation_repository.dart';
import 'medical_consultation_event.dart';
import 'medical_consultation_state.dart';

class MedicalConsultationBloc extends Bloc<MedicalConsultationEvent, MedicalConsultationState> {
  final MedicalConsultationRepository _repository;

  MedicalConsultationBloc(this._repository) : super(const MedicalConsultationState()) {
    on<SubmitConsultationEvent>(_onSubmitConsultation);
  }

  Future<void> _onSubmitConsultation(
    SubmitConsultationEvent event,
    Emitter<MedicalConsultationState> emit,
  ) async {
    emit(state.copyWith(status: MedicalConsultationStatus.loading, errorMessage: null));
    try {
      await _repository.submitConsultation(event.request);
      emit(state.copyWith(status: MedicalConsultationStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: MedicalConsultationStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
