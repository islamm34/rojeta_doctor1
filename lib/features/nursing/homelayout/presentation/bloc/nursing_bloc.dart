import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_staff_model.dart';

import '../../domain/repositories/i_nursing_repository.dart';
import 'nursing_event.dart';
import 'nursing_state.dart';

class NursingBloc extends Bloc<NursingEvent, NursingState> {
  final INursingRepository _repository;

  NursingBloc({required INursingRepository repository})
    : _repository = repository,
      super(const NursingState()) {
    on<ChangeNursingTabEvent>(_onChangeTab);
    on<LoadNursingDashboardData>(_onLoadDashboardData);
    on<LoadNursingServices>(_onLoadServices);
    on<AddNursingServiceEvent>(_onAddService);
    on<LoadNursingStaffEvent>(_onLoadStaff);
    on<AddNursingStaffEvent>(_onAddStaff);
    on<LoadNursingProfileEvent>(_onLoadProfile);
    on<UpdateNursingOfficeInfoEvent>(_onUpdateOfficeInfo);
    on<UpdateNursingWorkingHoursEvent>(_onUpdateWorkingHours);
    on<UpdateNursingSettingsEvent>(_onUpdateSettings);
  }

  void _onChangeTab(ChangeNursingTabEvent event, Emitter<NursingState> emit) {
    emit(state.copyWith(currentTabIndex: event.index));

    // Automatically load data based on the tab selected if not loaded
    if (event.index == 0 && state.dashboardData == null) {
      add(LoadNursingDashboardData());
    } else if (event.index == 1 && state.services.isEmpty) {
      add(LoadNursingServices());
    } else if (event.index == 2 && state.staff.isEmpty) {
      add(LoadNursingStaffEvent());
    } else if (event.index == 4 && state.profile == null) {
      add(LoadNursingProfileEvent());
    }
  }

  Future<void> _onLoadDashboardData(
    LoadNursingDashboardData event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));

    try {
      final data = await _repository.getDashboardData();
      emit(state.copyWith(status: NursingStatus.success, dashboardData: data));
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadServices(
    LoadNursingServices event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));

    try {
      final services = await _repository.getServices();
      emit(state.copyWith(status: NursingStatus.success, services: services));
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAddService(
    AddNursingServiceEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));

    try {
      final created = await _repository.addService(event.service);
      final updated = List.of(state.services)..insert(0, created);
      emit(state.copyWith(status: NursingStatus.success, services: updated));
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadStaff(
    LoadNursingStaffEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));

    try {
      final result = await _repository.getStaff();
      final staffList = result.staff;
      final stats = result.stats;

      emit(
        state.copyWith(
          status: NursingStatus.success,
          staff: staffList,
          staffStats: stats,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAddStaff(
    AddNursingStaffEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));

    try {
      final created = await _repository.addStaff(event.staff);
      final updatedStaff = List.of(state.staff)..insert(0, created);
      final currentStats = state.staffStats;
      final updatedStats = NursingStaffStatsModel(
        totalStaff: (currentStats?.totalStaff ?? 0) + 1,
        available:
            (currentStats?.available ?? 0) +
            ((created.status ?? '').toUpperCase() == 'AVAILABLE' ? 1 : 0),
        onDuty:
            (currentStats?.onDuty ?? 0) +
            ((created.status ?? '').toUpperCase() == 'BUSY' ||
                    (created.status ?? '').toUpperCase() == 'ON_DUTY' ||
                    (created.status ?? '').toUpperCase() == 'ON DUTY'
                ? 1
                : 0),
        onLeave:
            (currentStats?.onLeave ?? 0) +
            ((created.status ?? '').toUpperCase() == 'ON_LEAVE' ||
                    (created.status ?? '').toUpperCase() == 'ON LEAVE'
                ? 1
                : 0),
      );

      emit(
        state.copyWith(
          status: NursingStatus.success,
          staff: updatedStaff,
          staffStats: updatedStats,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadProfile(
    LoadNursingProfileEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));

    try {
      final profile = await _repository.getProfile();
      final office = await _repository.getOfficeInfo();
      final hours = await _repository.getWorkingHours();
      final settings = await _repository.getSettings();

      emit(
        state.copyWith(
          status: NursingStatus.success,
          profile: profile,
          officeInfo: office,
          workingHours: hours,
          settings: settings,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateOfficeInfo(
    UpdateNursingOfficeInfoEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      await _repository.updateOfficeInfo(event.officeInfo);
      emit(
        state.copyWith(
          status: NursingStatus.success,
          officeInfo: event.officeInfo,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateWorkingHours(
    UpdateNursingWorkingHoursEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      await _repository.updateWorkingHours(event.workingHours);
      emit(
        state.copyWith(
          status: NursingStatus.success,
          workingHours: event.workingHours,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateSettings(
    UpdateNursingSettingsEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      await _repository.updateSettings(event.settings);
      emit(
        state.copyWith(status: NursingStatus.success, settings: event.settings),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
