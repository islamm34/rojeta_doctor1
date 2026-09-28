import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/nursing/homelayout/data/models/nursing_profile_model.dart';
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
    on<UpdateNursingStaffEvent>(_onUpdateStaff);
    on<DeleteNursingStaffEvent>(_onDeleteStaff);
    on<DeleteNursingServiceEvent>(_onDeleteService);
    on<LoadNursingProfileEvent>(_onLoadProfile);
    on<UpdateNursingOfficeInfoEvent>(_onUpdateOfficeInfo);
    on<UpdateNursingWorkingHoursEvent>(_onUpdateWorkingHours);
    on<UpdateNursingSettingsEvent>(_onUpdateSettings);
    on<LoadNursingCoverageAreasEvent>(_onLoadCoverageAreas);
    on<AddNursingCoverageAreaEvent>(_onAddCoverageArea);
    on<DeleteNursingCoverageAreaEvent>(_onDeleteCoverageArea);
    on<ToggleNursingCoverageAreaEvent>(_onToggleCoverageArea);
    on<LoadNursingDocumentsEvent>(_onLoadDocuments);
    on<UploadNursingDocumentEvent>(_onUploadDocument);
    on<DeleteNursingDocumentEvent>(_onDeleteDocument);
    on<LoadNursingPaymentSettingsEvent>(_onLoadPaymentSettings);
    on<UpdateNursingPaymentSettingsEvent>(_onUpdatePaymentSettings);
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

  Future<void> _onUpdateStaff(
    UpdateNursingStaffEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      final updatedStaffList = state.staff.map((s) {
        return s.id == event.staff.id ? event.staff : s;
      }).toList();
      emit(
        state.copyWith(status: NursingStatus.success, staff: updatedStaffList),
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

  Future<void> _onDeleteStaff(
    DeleteNursingStaffEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      await _repository.deleteStaff(event.staffId);
      final updatedStaff = state.staff
          .where((s) => s.id != event.staffId)
          .toList();
      emit(state.copyWith(status: NursingStatus.success, staff: updatedStaff));
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onDeleteService(
    DeleteNursingServiceEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      await _repository.deleteService(event.serviceId);
      final updatedServices = state.services
          .where((s) => s.id != event.serviceId)
          .toList();
      emit(
        state.copyWith(
          status: NursingStatus.success,
          services: updatedServices,
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
      final coverage = await _repository.getCoverageAreas();
      final docs = await _repository.getDocuments();
      final payment = await _repository.getPaymentSettings();

      emit(
        state.copyWith(
          status: NursingStatus.success,
          profile: profile,
          officeInfo: office,
          workingHours: hours,
          settings: settings,
          coverageAreas: coverage,
          documents: docs,
          paymentSettings: payment,
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

  Future<void> _onLoadCoverageAreas(
    LoadNursingCoverageAreasEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      final areas = await _repository.getCoverageAreas();
      emit(state.copyWith(status: NursingStatus.success, coverageAreas: areas));
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAddCoverageArea(
    AddNursingCoverageAreaEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      final created = await _repository.addCoverageArea(event.area);
      final updated = List.of(state.coverageAreas)..insert(0, created);
      emit(
        state.copyWith(status: NursingStatus.success, coverageAreas: updated),
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

  Future<void> _onDeleteCoverageArea(
    DeleteNursingCoverageAreaEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      await _repository.deleteCoverageArea(event.areaId);
      final updated = state.coverageAreas
          .where((a) => a.id != event.areaId)
          .toList();
      emit(
        state.copyWith(status: NursingStatus.success, coverageAreas: updated),
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

  Future<void> _onToggleCoverageArea(
    ToggleNursingCoverageAreaEvent event,
    Emitter<NursingState> emit,
  ) async {
    try {
      final updated = state.coverageAreas.map((a) {
        if (a.id == event.areaId) {
          return a.copyWith(isActive: event.isActive);
        }
        return a;
      }).toList();
      emit(state.copyWith(coverageAreas: updated));
      await _repository.toggleCoverageArea(event.areaId, event.isActive);
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadDocuments(
    LoadNursingDocumentsEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      final docs = await _repository.getDocuments();
      emit(state.copyWith(status: NursingStatus.success, documents: docs));
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUploadDocument(
    UploadNursingDocumentEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      final uploaded = await _repository.uploadDocument(
        event.documentType,
        event.filePath,
      );
      final existingIndex = state.documents.indexWhere(
        (d) => d.type == event.documentType,
      );
      List<NursingDocumentItemModel> updated;
      if (existingIndex >= 0) {
        updated = List.of(state.documents);
        updated[existingIndex] = uploaded;
      } else {
        updated = List.of(state.documents)..insert(0, uploaded);
      }
      emit(state.copyWith(status: NursingStatus.success, documents: updated));
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onDeleteDocument(
    DeleteNursingDocumentEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      await _repository.deleteDocument(event.documentId);
      final updated = state.documents
          .where((d) => d.id != event.documentId)
          .toList();
      emit(state.copyWith(status: NursingStatus.success, documents: updated));
    } catch (e) {
      emit(
        state.copyWith(
          status: NursingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadPaymentSettings(
    LoadNursingPaymentSettingsEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      final payment = await _repository.getPaymentSettings();
      emit(
        state.copyWith(status: NursingStatus.success, paymentSettings: payment),
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

  Future<void> _onUpdatePaymentSettings(
    UpdateNursingPaymentSettingsEvent event,
    Emitter<NursingState> emit,
  ) async {
    emit(state.copyWith(status: NursingStatus.loading));
    try {
      await _repository.updatePaymentSettings(event.paymentSettings);
      emit(
        state.copyWith(
          status: NursingStatus.success,
          paymentSettings: event.paymentSettings,
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
}
