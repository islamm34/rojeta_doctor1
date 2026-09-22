import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/i_hospital_repository.dart';
import 'hospital_event.dart';
import 'hospital_state.dart';

class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  final IHospitalRepository repository;

  HospitalBloc({required this.repository}) : super(const HospitalState()) {
    on<LoadHospitalDashboardEvent>(_onLoadDashboard);
  }

  Future<void> _onLoadDashboard(
    LoadHospitalDashboardEvent event,
    Emitter<HospitalState> emit,
  ) async {
    emit(
      state.copyWith(status: HospitalStatus.loading, clearErrorMessage: true),
    );

    try {
      final data = await repository.getDashboardData();
      emit(state.copyWith(status: HospitalStatus.success, dashboardData: data));
    } catch (e) {
      emit(
        state.copyWith(
          status: HospitalStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
