import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/working_hours_model.dart';
import '../../domain/usecases/get_lab_info_usecase.dart';
import '../../domain/usecases/get_settings_data_usecase.dart';
import '../../domain/usecases/get_working_hours_usecase.dart';
import '../../domain/usecases/update_general_settings_usecase.dart';
import '../../domain/usecases/update_lab_info_usecase.dart';
import '../../domain/usecases/update_working_hours_usecase.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsDataUseCase getSettingsDataUseCase;
  final UpdateGeneralSettingsUseCase updateGeneralSettingsUseCase;
  final GetLabInfoUseCase getLabInfoUseCase;
  final UpdateLabInfoUseCase updateLabInfoUseCase;
  final GetWorkingHoursUseCase getWorkingHoursUseCase;
  final UpdateWorkingHoursUseCase updateWorkingHoursUseCase;

  SettingsBloc({
    required this.getSettingsDataUseCase,
    required this.updateGeneralSettingsUseCase,
    required this.getLabInfoUseCase,
    required this.updateLabInfoUseCase,
    required this.getWorkingHoursUseCase,
    required this.updateWorkingHoursUseCase,
  }) : super(const SettingsState()) {
    on<LoadSettingsData>(_onLoadData);
    on<ToggleEmailNotifications>(_onToggleEmail);
    on<ToggleBookingUpdates>(_onToggleBooking);
    on<TogglePushNotifications>(_onTogglePush);
    on<ToggleAppointmentReminders>(_onToggleAppointment);
    on<LoadLabInfoEvent>(_onLoadLabInfo);
    on<UpdateLabInfoEvent>(_onUpdateLabInfo);
    on<LoadWorkingHoursEvent>(_onLoadWorkingHours);
    on<UpdateDayScheduleEvent>(_onUpdateDaySchedule);
    on<AddSpecialDateEvent>(_onAddSpecialDate);
    on<RemoveSpecialDateEvent>(_onRemoveSpecialDate);
  }

  Future<void> _onLoadData(LoadSettingsData event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: SettingsStatus.loading));

    final profileResult = await getSettingsDataUseCase.getLabProfile();
    final settingsResult = await getSettingsDataUseCase.getGeneralSettings();

    profileResult.fold(
      (failure) => emit(state.copyWith(status: SettingsStatus.failure, errorMessage: failure.message)),
      (profile) {
        settingsResult.fold(
          (failure) => emit(state.copyWith(status: SettingsStatus.failure, errorMessage: failure.message)),
          (settings) {
            emit(state.copyWith(
              status: SettingsStatus.success,
              profile: profile,
              settings: settings,
            ));
          },
        );
      },
    );
  }

  void _onToggleEmail(ToggleEmailNotifications event, Emitter<SettingsState> emit) {
    final updatedSettings = state.settings.copyWith(emailNotifications: event.value);
    emit(state.copyWith(settings: updatedSettings));
    updateGeneralSettingsUseCase(updatedSettings);
  }

  void _onToggleBooking(ToggleBookingUpdates event, Emitter<SettingsState> emit) {
    final updatedSettings = state.settings.copyWith(bookingUpdates: event.value);
    emit(state.copyWith(settings: updatedSettings));
    updateGeneralSettingsUseCase(updatedSettings);
  }

  void _onTogglePush(TogglePushNotifications event, Emitter<SettingsState> emit) {
    final updatedSettings = state.settings.copyWith(pushNotifications: event.value);
    emit(state.copyWith(settings: updatedSettings));
    updateGeneralSettingsUseCase(updatedSettings);
  }

  void _onToggleAppointment(ToggleAppointmentReminders event, Emitter<SettingsState> emit) {
    final updatedSettings = state.settings.copyWith(appointmentReminders: event.value);
    emit(state.copyWith(settings: updatedSettings));
    updateGeneralSettingsUseCase(updatedSettings);
  }

  Future<void> _onLoadLabInfo(LoadLabInfoEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: SettingsStatus.loading));
    final result = await getLabInfoUseCase();
    result.fold(
      (failure) => emit(state.copyWith(status: SettingsStatus.failure, errorMessage: failure.message)),
      (info) => emit(state.copyWith(status: SettingsStatus.success, labInfo: info)),
    );
  }

  Future<void> _onUpdateLabInfo(UpdateLabInfoEvent event, Emitter<SettingsState> emit) async {
    if (state.labInfo != null) {
      final updatedInfo = state.labInfo!.copyWith(
        labName: event.labName,
        licenseNumber: event.licenseNumber,
        primaryContactEmail: event.primaryContactEmail,
        phoneNumber: event.phoneNumber,
        laboratoryDescription: event.description,
      );
      emit(state.copyWith(labInfo: updatedInfo));
      await updateLabInfoUseCase(updatedInfo);
    }
  }

  Future<void> _onLoadWorkingHours(LoadWorkingHoursEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: SettingsStatus.loading));
    final result = await getWorkingHoursUseCase();
    result.fold(
      (failure) => emit(state.copyWith(status: SettingsStatus.failure, errorMessage: failure.message)),
      (hours) => emit(state.copyWith(status: SettingsStatus.success, workingHours: hours)),
    );
  }

  Future<void> _onUpdateDaySchedule(UpdateDayScheduleEvent event, Emitter<SettingsState> emit) async {
    if (state.workingHours != null) {
      final updatedWeek = (state.workingHours!.standardWeek ?? []).map((day) {
        if (day.dayName == event.dayName) {
          return day.copyWith(
            isClosed: event.isClosed,
            openingTime: event.openingTime,
            closingTime: event.closingTime,
          );
        }
        return day;
      }).toList();
      final updatedWorkingHours = state.workingHours!.copyWith(standardWeek: updatedWeek);
      emit(state.copyWith(workingHours: updatedWorkingHours));
      await updateWorkingHoursUseCase(updatedWorkingHours);
    }
  }

  Future<void> _onAddSpecialDate(AddSpecialDateEvent event, Emitter<SettingsState> emit) async {
    if (state.workingHours != null) {
      final newDate = SpecialDateModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        dateStr: event.dateStr,
        eventName: event.eventName,
        isClosed: event.isClosed,
        openingTime: event.openingTime,
        closingTime: event.closingTime,
      );
      final updatedOverrides = List<SpecialDateModel>.from(state.workingHours!.upcomingOverrides ?? [])..add(newDate);
      final updatedWorkingHours = state.workingHours!.copyWith(upcomingOverrides: updatedOverrides);
      emit(state.copyWith(workingHours: updatedWorkingHours));
      await updateWorkingHoursUseCase(updatedWorkingHours);
    }
  }

  Future<void> _onRemoveSpecialDate(RemoveSpecialDateEvent event, Emitter<SettingsState> emit) async {
    if (state.workingHours != null) {
      final updatedOverrides = (state.workingHours!.upcomingOverrides ?? []).where((element) => element.id != event.id).toList();
      final updatedWorkingHours = state.workingHours!.copyWith(upcomingOverrides: updatedOverrides);
      emit(state.copyWith(workingHours: updatedWorkingHours));
      await updateWorkingHoursUseCase(updatedWorkingHours);
    }
  }
}
