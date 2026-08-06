import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/doctor/profile/data/models/settings_model.dart';
import '../../../data/mocks/profile_mock_data.dart';
import '../../../domain/usecases/get_profile_use_case.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileBloc({required this.getProfileUseCase}) : super(const ProfileState()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<SwitchTabEvent>(_onSwitchTab);
    on<ToggleServiceEvent>(_onToggleService);
    on<UpdateServicePriceEvent>(_onUpdateServicePrice);
    on<SwitchPaymentTypeEvent>(_onSwitchPaymentType);
    on<DeleteClinicEvent>(_onDeleteClinic);
    on<ToggleSettingEvent>(_onToggleSetting);
  }

  void _onLoadProfile(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final response = await getProfileUseCase();
      final profileModel = response.toProfileModel();
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profileModel,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
          profile: ProfileMockData.mockProfile,
        ),
      );
    }
  }

  void _onSwitchTab(SwitchTabEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(isProfileTabSelected: event.isProfile));
  }

  void _onToggleService(ToggleServiceEvent event, Emitter<ProfileState> emit) {
    if (state.profile == null) return;

    final updatedServices = state.profile!.services.map((s) {
      if (s.id == event.serviceId) {
        return s.copyWith(isEnabled: event.isEnabled);
      }
      return s;
    }).toList();

    final updatedProfile = state.profile!.copyWith(services: updatedServices);
    emit(state.copyWith(profile: updatedProfile));
  }

  void _onUpdateServicePrice(
    UpdateServicePriceEvent event,
    Emitter<ProfileState> emit,
  ) {
    if (state.profile == null) return;

    final updatedServices = state.profile!.services.map((s) {
      if (s.id == event.serviceId) {
        return s.copyWith(price: event.newPrice);
      }
      return s;
    }).toList();

    final updatedProfile = state.profile!.copyWith(services: updatedServices);
    emit(state.copyWith(profile: updatedProfile));
  }

  void _onSwitchPaymentType(
    SwitchPaymentTypeEvent event,
    Emitter<ProfileState> emit,
  ) {
    if (state.profile == null) return;

    final updatedPayment = state.profile!.paymentDetails.copyWith(
      paymentType: event.type,
    );
    final updatedProfile = state.profile!.copyWith(
      paymentDetails: updatedPayment,
    );

    emit(state.copyWith(profile: updatedProfile));
  }

  void _onDeleteClinic(DeleteClinicEvent event, Emitter<ProfileState> emit) {
    if (state.profile == null) return;

    final updatedClinics = state.profile!.clinics
        .where((c) => c.id != event.clinicId)
        .toList();
    final updatedProfile = state.profile!.copyWith(clinics: updatedClinics);

    emit(state.copyWith(profile: updatedProfile));
  }

  void _onToggleSetting(ToggleSettingEvent event, Emitter<ProfileState> emit) {
    SettingsModel updatedSettings = state.settings;
    switch (event.settingKey) {
      case 'emailNotifications':
        updatedSettings = state.settings.copyWith(
          emailNotifications: event.isEnabled,
        );
        break;
      case 'smsNotifications':
        updatedSettings = state.settings.copyWith(
          smsNotifications: event.isEnabled,
        );
        break;
      case 'pushNotifications':
        updatedSettings = state.settings.copyWith(
          pushNotifications: event.isEnabled,
        );
        break;
      case 'appointmentReminders':
        updatedSettings = state.settings.copyWith(
          appointmentReminders: event.isEnabled,
        );
        break;
      case 'marketingEmails':
        updatedSettings = state.settings.copyWith(
          marketingEmails: event.isEnabled,
        );
        break;
    }
    emit(state.copyWith(settings: updatedSettings));
  }
}
