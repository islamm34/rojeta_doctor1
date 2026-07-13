import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';
import '../../domain/usecases/get_settings_data_usecase.dart';
import '../../domain/usecases/update_general_settings_usecase.dart';
import '../../domain/entities/general_settings.dart';
import '../../data/models/lab_info_model.dart';
import '../../data/models/working_hours_model.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsDataUseCase getSettingsDataUseCase;
  final UpdateGeneralSettingsUseCase updateGeneralSettingsUseCase;

  SettingsBloc({
    required this.getSettingsDataUseCase,
    required this.updateGeneralSettingsUseCase,
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
    emit(state.copyWith(
      settings: state.settings.copyWith(emailNotifications: event.value),
    ));
  }

  void _onToggleBooking(ToggleBookingUpdates event, Emitter<SettingsState> emit) {
    emit(state.copyWith(
      settings: state.settings.copyWith(bookingUpdates: event.value),
    ));
  }

  void _onTogglePush(TogglePushNotifications event, Emitter<SettingsState> emit) {
    emit(state.copyWith(
      settings: state.settings.copyWith(pushNotifications: event.value),
    ));
  }

  void _onToggleAppointment(ToggleAppointmentReminders event, Emitter<SettingsState> emit) {
    emit(state.copyWith(
      settings: state.settings.copyWith(appointmentReminders: event.value),
    ));
  }

  void _onLoadLabInfo(LoadLabInfoEvent event, Emitter<SettingsState> emit) {
    // Mock Data for UI
    final mockData = LabInfoModel(
      labName: 'City Lab',
      licenseNumber: 'CLIA-882944-B',
      primaryContactEmail: 'admin@centraldiag.com',
      phoneNumber: '+1 (555) 012-3456',
      laboratoryDescription: 'Founded in 2005, Central Diagnostic Laboratory provides state-of-the-art diagnostic services focusing on hematology, microbiology',
      isVerified: true,
      verificationYear: '2026',
    );
    emit(state.copyWith(labInfo: mockData));
  }

  void _onUpdateLabInfo(UpdateLabInfoEvent event, Emitter<SettingsState> emit) {
    if (state.labInfo != null) {
      final updatedInfo = state.labInfo!.copyWith(
        labName: event.labName,
        licenseNumber: event.licenseNumber,
        primaryContactEmail: event.primaryContactEmail,
        phoneNumber: event.phoneNumber,
        laboratoryDescription: event.description,
      );
      emit(state.copyWith(labInfo: updatedInfo));
    }
  }

  void _onLoadWorkingHours(LoadWorkingHoursEvent event, Emitter<SettingsState> emit) {
    // Mock Data for UI
    final mockData = WorkingHoursModel(
      standardWeek: [
        DayScheduleModel(dayName: 'Monday', openingTime: '08:00 AM', closingTime: '06:00 PM'),
        DayScheduleModel(dayName: 'Tuesday', openingTime: '08:00 AM', closingTime: '06:00 PM'),
        DayScheduleModel(dayName: 'Wednesday', openingTime: '08:00 AM', closingTime: '06:00 PM'),
        DayScheduleModel(dayName: 'Thursday', openingTime: '08:00 AM', closingTime: '06:00 PM'),
        DayScheduleModel(dayName: 'Friday', openingTime: '08:00 AM', closingTime: '06:00 PM'),
        DayScheduleModel(dayName: 'Saturday', isClosed: true, openingTime: '08:00 AM', closingTime: '06:00 PM'),
        DayScheduleModel(dayName: 'Sunday', isClosed: true, openingTime: '08:00 AM', closingTime: '06:00 PM'),
      ],
      upcomingOverrides: [
        SpecialDateModel(id: '1', dateStr: 'DEC 25', eventName: 'Christmas Day', isClosed: true),
        SpecialDateModel(id: '2', dateStr: 'JAN 01', eventName: 'New Year\'s Day', openingTime: '10:00 AM', closingTime: '02:00 PM'),
      ],
    );
    emit(state.copyWith(workingHours: mockData));
  }

  void _onUpdateDaySchedule(UpdateDayScheduleEvent event, Emitter<SettingsState> emit) {
    if (state.workingHours != null) {
      final updatedWeek = state.workingHours!.standardWeek.map((day) {
        if (day.dayName == event.dayName) {
          return day.copyWith(
            isClosed: event.isClosed,
            openingTime: event.openingTime,
            closingTime: event.closingTime,
          );
        }
        return day;
      }).toList();
      emit(state.copyWith(workingHours: state.workingHours!.copyWith(standardWeek: updatedWeek)));
    }
  }

  void _onAddSpecialDate(AddSpecialDateEvent event, Emitter<SettingsState> emit) {
    if (state.workingHours != null) {
      final newDate = SpecialDateModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        dateStr: event.dateStr,
        eventName: event.eventName,
        isClosed: event.isClosed,
        openingTime: event.openingTime,
        closingTime: event.closingTime,
      );
      final updatedOverrides = List<SpecialDateModel>.from(state.workingHours!.upcomingOverrides)..add(newDate);
      emit(state.copyWith(workingHours: state.workingHours!.copyWith(upcomingOverrides: updatedOverrides)));
    }
  }

  void _onRemoveSpecialDate(RemoveSpecialDateEvent event, Emitter<SettingsState> emit) {
    if (state.workingHours != null) {
      final updatedOverrides = state.workingHours!.upcomingOverrides.where((element) => element.id != event.id).toList();
      emit(state.copyWith(workingHours: state.workingHours!.copyWith(upcomingOverrides: updatedOverrides)));
    }
  }
}
