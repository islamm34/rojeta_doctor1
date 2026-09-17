import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/home_visits_repository.dart';
import 'home_visits_event.dart';
import 'home_visits_state.dart';

class HomeVisitsBloc extends Bloc<HomeVisitsEvent, HomeVisitsState> {
  final HomeVisitsRepository repository;

  HomeVisitsBloc({required this.repository}) : super(const HomeVisitsState()) {
    on<LoadHomeVisitsConfig>(_onLoadConfig);
    on<ToggleServiceStatus>(_onToggleStatus);
    on<UpdateCollectionFee>(_onUpdateFee);
    on<UpdateMinimumBooking>(_onUpdateMinimumBooking);
    on<ToggleWeekdaysTab>(_onToggleWeekdaysTab);
    on<SaveHomeVisitsConfig>(_onSaveConfig);
  }

  Future<void> _onLoadConfig(
    LoadHomeVisitsConfig event,
    Emitter<HomeVisitsState> emit,
  ) async {
    emit(state.copyWithClearError(status: HomeVisitsStatus.loading));

    final result = await repository.getHomeVisitsConfig();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeVisitsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (config) => emit(
        state.copyWithClearError(
          status: HomeVisitsStatus.success,
          config: config,
        ),
      ),
    );
  }

  void _onToggleStatus(
    ToggleServiceStatus event,
    Emitter<HomeVisitsState> emit,
  ) {
    emit(
      state.copyWithClearError(
        config: state.config.copyWith(
          isServiceVisible: !(state.config.isServiceVisible ?? false),
        ),
      ),
    );
  }

  void _onUpdateFee(UpdateCollectionFee event, Emitter<HomeVisitsState> emit) {
    emit(
      state.copyWithClearError(
        config: state.config.copyWith(collectionFee: event.fee),
      ),
    );
  }

  void _onUpdateMinimumBooking(
    UpdateMinimumBooking event,
    Emitter<HomeVisitsState> emit,
  ) {
    emit(
      state.copyWithClearError(
        config: state.config.copyWith(minimumBookingAmount: event.amount),
      ),
    );
  }

  void _onToggleWeekdaysTab(
    ToggleWeekdaysTab event,
    Emitter<HomeVisitsState> emit,
  ) {
    emit(
      state.copyWithClearError(
        config: state.config.copyWith(isWeekdaysTabActive: event.isWeekdays),
      ),
    );
  }

  Future<void> _onSaveConfig(
    SaveHomeVisitsConfig event,
    Emitter<HomeVisitsState> emit,
  ) async {
    emit(state.copyWithClearError(status: HomeVisitsStatus.saving));

    final result = await repository.updateHomeVisitsConfig(state.config);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeVisitsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) {
        emit(state.copyWithClearError(status: HomeVisitsStatus.saveSuccess));
        emit(state.copyWithClearError(status: HomeVisitsStatus.success));
      },
    );
  }
}
