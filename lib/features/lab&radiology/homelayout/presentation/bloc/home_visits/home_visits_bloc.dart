import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../shared/models/time_slot_model.dart';
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
    on<AddHomeVisitTimeSlot>(_onAddTimeSlot);
    on<RemoveHomeVisitTimeSlot>(_onRemoveTimeSlot);
    on<ToggleHomeVisitTimeSlotStatus>(_onToggleTimeSlotStatus);
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

  void _onAddTimeSlot(
    AddHomeVisitTimeSlot event,
    Emitter<HomeVisitsState> emit,
  ) {
    if (event.isWeekday) {
      final updated = List<TimeSlotModel>.from(
        state.config.weekdaySlots ?? const [],
      )..add(event.slot);
      emit(
        state.copyWithClearError(
          config: state.config.copyWith(weekdaySlots: updated),
        ),
      );
    } else {
      final updated = List<TimeSlotModel>.from(
        state.config.weekendSlots ?? const [],
      )..add(event.slot);
      emit(
        state.copyWithClearError(
          config: state.config.copyWith(weekendSlots: updated),
        ),
      );
    }
  }

  void _onRemoveTimeSlot(
    RemoveHomeVisitTimeSlot event,
    Emitter<HomeVisitsState> emit,
  ) {
    if (event.isWeekday) {
      final current = state.config.weekdaySlots ?? const [];
      if (event.index >= 0 && event.index < current.length) {
        final updated = List<TimeSlotModel>.from(current)
          ..removeAt(event.index);
        emit(
          state.copyWithClearError(
            config: state.config.copyWith(weekdaySlots: updated),
          ),
        );
      }
    } else {
      final current = state.config.weekendSlots ?? const [];
      if (event.index >= 0 && event.index < current.length) {
        final updated = List<TimeSlotModel>.from(current)
          ..removeAt(event.index);
        emit(
          state.copyWithClearError(
            config: state.config.copyWith(weekendSlots: updated),
          ),
        );
      }
    }
  }

  void _onToggleTimeSlotStatus(
    ToggleHomeVisitTimeSlotStatus event,
    Emitter<HomeVisitsState> emit,
  ) {
    if (event.isWeekday) {
      final current = state.config.weekdaySlots ?? const [];
      if (event.index >= 0 && event.index < current.length) {
        final currentSlot = current[event.index];
        final nextStatus = currentSlot.status == TimeSlotStatus.active
            ? TimeSlotStatus.ready
            : (currentSlot.status == TimeSlotStatus.ready
                  ? TimeSlotStatus.disabled
                  : TimeSlotStatus.active);
        final updated = List<TimeSlotModel>.from(current)
          ..[event.index] = currentSlot.copyWith(status: nextStatus);
        emit(
          state.copyWithClearError(
            config: state.config.copyWith(weekdaySlots: updated),
          ),
        );
      }
    } else {
      final current = state.config.weekendSlots ?? const [];
      if (event.index >= 0 && event.index < current.length) {
        final currentSlot = current[event.index];
        final nextStatus = currentSlot.status == TimeSlotStatus.active
            ? TimeSlotStatus.ready
            : (currentSlot.status == TimeSlotStatus.ready
                  ? TimeSlotStatus.disabled
                  : TimeSlotStatus.active);
        final updated = List<TimeSlotModel>.from(current)
          ..[event.index] = currentSlot.copyWith(status: nextStatus);
        emit(
          state.copyWithClearError(
            config: state.config.copyWith(weekendSlots: updated),
          ),
        );
      }
    }
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
