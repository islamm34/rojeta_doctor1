import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_lab_dashboard_usecase.dart';
import 'lab_home_event.dart';
import 'lab_home_state.dart';

class LabHomeBloc extends Bloc<LabHomeEvent, LabHomeState> {
  final GetLabDashboardUseCase getLabDashboardUseCase;

  LabHomeBloc({required this.getLabDashboardUseCase})
    : super(const LabHomeState()) {
    on<LoadLabHomeDataEvent>(_onLoadLabHomeData);
  }

  Future<void> _onLoadLabHomeData(
    LoadLabHomeDataEvent event,
    Emitter<LabHomeState> emit,
  ) async {
    emit(state.copyWith(status: LabHomeStatus.loading, clearError: true));
    final result = await getLabDashboardUseCase(userType: event.userType);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: LabHomeStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (data) => emit(
        state.copyWith(status: LabHomeStatus.success, dashboardData: data),
      ),
    );
  }
}
