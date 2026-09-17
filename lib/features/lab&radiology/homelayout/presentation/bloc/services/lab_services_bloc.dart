import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/delete_lab_service_usecase.dart';
import '../../../domain/usecases/get_lab_services_usecase.dart';
import 'lab_services_event.dart';
import 'lab_services_state.dart';

class LabServicesBloc extends Bloc<LabServicesEvent, LabServicesState> {
  final GetLabServicesUseCase getLabServicesUseCase;
  final DeleteLabServiceUseCase? deleteLabServiceUseCase;

  LabServicesBloc({
    required this.getLabServicesUseCase,
    this.deleteLabServiceUseCase,
  }) : super(const LabServicesState()) {
    on<FetchLabServicesEvent>(_onFetchLabServices);
    on<DeleteLabServiceEvent>(_onDeleteLabService);
  }

  Future<void> _onFetchLabServices(
    FetchLabServicesEvent event,
    Emitter<LabServicesState> emit,
  ) async {
    emit(state.copyWith(status: LabServicesStatus.loading, clearError: true));

    final result = await getLabServicesUseCase(userType: event.userType);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: LabServicesStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (response) => emit(
        state.copyWith(
          status: LabServicesStatus.success,
          services: response.services ?? [],
          totalActiveServices: response.totalActiveServices ?? 0,
          homeVisitsAvailableCount: response.homeVisitsAvailableCount ?? 0,
        ),
      ),
    );
  }

  Future<void> _onDeleteLabService(
    DeleteLabServiceEvent event,
    Emitter<LabServicesState> emit,
  ) async {
    if (deleteLabServiceUseCase == null) return;

    final result = await deleteLabServiceUseCase!(
      event.serviceId,
      userType: event.userType,
    );

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) {
        final updatedServices = state.services
            .where((service) => service.id != event.serviceId)
            .toList();
        final totalActive = updatedServices
            .where((s) => s.isActive ?? true)
            .length;
        final homeVisits = updatedServices
            .where((s) => s.isHomeCollectionAvailable == true)
            .length;

        emit(
          state.copyWith(
            services: updatedServices,
            totalActiveServices: totalActive,
            homeVisitsAvailableCount: homeVisits,
          ),
        );
      },
    );
  }
}
