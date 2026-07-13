import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/settings_model.dart';
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUseCase getSettingsUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;

  SettingsBloc({
    required this.getSettingsUseCase,
    required this.updateSettingsUseCase,
  }) : super(const SettingsState()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<TogglePushNotificationsEvent>(_onTogglePushNotifications);
    on<ChangeLanguageEvent>(_onChangeLanguage);
    on<ToggleAlertPreferenceEvent>(_onToggleAlertPreference);
  }

  Future<void> _onToggleAlertPreference(ToggleAlertPreferenceEvent event, Emitter<SettingsState> emit) async {
    if (state.settings == null) return;

    SettingsModel newSettings;
    switch (event.type) {
      case AlertPreferenceType.newBookings:
        newSettings = SettingsModel(
          pushNotificationsEnabled: state.settings!.pushNotificationsEnabled,
          languageCode: state.settings!.languageCode,
          newBookingsEnabled: event.isEnabled,
          appointmentRemindersEnabled: state.settings!.appointmentRemindersEnabled,
          emergencyRequestsEnabled: state.settings!.emergencyRequestsEnabled,
          paymentNotificationsEnabled: state.settings!.paymentNotificationsEnabled,
        );
        break;
      case AlertPreferenceType.appointmentReminders:
        newSettings = SettingsModel(
          pushNotificationsEnabled: state.settings!.pushNotificationsEnabled,
          languageCode: state.settings!.languageCode,
          newBookingsEnabled: state.settings!.newBookingsEnabled,
          appointmentRemindersEnabled: event.isEnabled,
          emergencyRequestsEnabled: state.settings!.emergencyRequestsEnabled,
          paymentNotificationsEnabled: state.settings!.paymentNotificationsEnabled,
        );
        break;
      case AlertPreferenceType.emergencyRequests:
        newSettings = SettingsModel(
          pushNotificationsEnabled: state.settings!.pushNotificationsEnabled,
          languageCode: state.settings!.languageCode,
          newBookingsEnabled: state.settings!.newBookingsEnabled,
          appointmentRemindersEnabled: state.settings!.appointmentRemindersEnabled,
          emergencyRequestsEnabled: event.isEnabled,
          paymentNotificationsEnabled: state.settings!.paymentNotificationsEnabled,
        );
        break;
      case AlertPreferenceType.paymentNotifications:
        newSettings = SettingsModel(
          pushNotificationsEnabled: state.settings!.pushNotificationsEnabled,
          languageCode: state.settings!.languageCode,
          newBookingsEnabled: state.settings!.newBookingsEnabled,
          appointmentRemindersEnabled: state.settings!.appointmentRemindersEnabled,
          emergencyRequestsEnabled: state.settings!.emergencyRequestsEnabled,
          paymentNotificationsEnabled: event.isEnabled,
        );
        break;
    }

    emit(state.copyWith(status: SettingsStatus.loading, clearError: true));

    final result = await updateSettingsUseCase(newSettings);
    result.fold(
      (failure) => emit(state.copyWith(
        status: SettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        status: SettingsStatus.success,
        settings: newSettings,
      )),
    );
  }

  Future<void> _onLoadSettings(LoadSettingsEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: SettingsStatus.loading, clearError: true));
    final result = await getSettingsUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        status: SettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (settings) => emit(state.copyWith(
        status: SettingsStatus.success,
        settings: settings,
      )),
    );
  }

  Future<void> _onTogglePushNotifications(TogglePushNotificationsEvent event, Emitter<SettingsState> emit) async {
    if (state.settings == null) return;
    
    final newSettings = SettingsModel(
      pushNotificationsEnabled: event.isEnabled,
      languageCode: state.settings!.languageCode,
    );
    
    emit(state.copyWith(status: SettingsStatus.loading, clearError: true));
    
    final result = await updateSettingsUseCase(newSettings);
    result.fold(
      (failure) => emit(state.copyWith(
        status: SettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        status: SettingsStatus.success,
        settings: newSettings,
      )),
    );
  }

  Future<void> _onChangeLanguage(ChangeLanguageEvent event, Emitter<SettingsState> emit) async {
    if (state.settings == null) return;

    final newSettings = SettingsModel(
      pushNotificationsEnabled: state.settings!.pushNotificationsEnabled,
      languageCode: event.languageCode,
    );
    
    emit(state.copyWith(status: SettingsStatus.loading, clearError: true));
    
    final result = await updateSettingsUseCase(newSettings);
    result.fold(
      (failure) => emit(state.copyWith(
        status: SettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        status: SettingsStatus.success,
        settings: newSettings,
      )),
    );
  }
}
