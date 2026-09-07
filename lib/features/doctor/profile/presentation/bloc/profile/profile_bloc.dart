import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/error/exceptions.dart';
import 'package:rojeta_doctor/core/local/user_data.dart';
import 'package:rojeta_doctor/core/local/user_hive_helper.dart';
import 'package:rojeta_doctor/features/doctor/profile/data/models/payment_details_model.dart';
import 'package:rojeta_doctor/features/doctor/profile/data/models/profile_model.dart';
import 'package:rojeta_doctor/features/doctor/profile/data/models/settings_model.dart';
import '../../../domain/repositories/profile_repository.dart';
import '../../../domain/usecases/get_profile_use_case.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final ProfileRepository profileRepository;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.profileRepository,
  }) : super(const ProfileState()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<SwitchTabEvent>(_onSwitchTab);
    on<ToggleServiceEvent>(_onToggleService);
    on<UpdateServicePriceEvent>(_onUpdateServicePrice);
    on<SaveServicesEvent>(_onSaveServices);
    on<SwitchPaymentTypeEvent>(_onSwitchPaymentType);
    on<SavePaymentDetailsEvent>(_onSavePaymentDetails);
    on<DeleteClinicEvent>(_onDeleteClinic);
    on<AddClinicSubmittedEvent>(_onAddClinic);
    on<UpdateClinicSubmittedEvent>(_onUpdateClinic);
    on<UpdateProfileDetailsEvent>(_onUpdateProfileDetails);
    on<LoadSettingsEvent>(_onLoadSettings);
    on<ToggleSettingEvent>(_onToggleSetting);
    on<SaveSettingsEvent>(_onSaveSettings);
  }

  ProfileModel _enrichWithCachedUser(ProfileModel? base) {
    final cachedUser = UserHiveHelper.getUser();
    final name = (base?.fullName.isNotEmpty == true)
        ? base!.fullName
        : (cachedUser?.name?.isNotEmpty == true
            ? cachedUser!.name!
            : '${cachedUser?.firstName ?? ''} ${cachedUser?.secondName ?? ''}'.trim());
    final email = (base?.email.isNotEmpty == true)
        ? base!.email
        : (cachedUser?.email ?? '');
    final phone = (base?.phone.isNotEmpty == true)
        ? base!.phone
        : (cachedUser?.phone ?? '');
    final image = (base?.imageUrl?.isNotEmpty == true)
        ? base!.imageUrl
        : cachedUser?.image;

    if (base != null) {
      return base.copyWith(
        fullName: name.isNotEmpty ? name : 'Doctor',
        email: email,
        phone: phone,
        imageUrl: image,
      );
    }
    return ProfileModel(
      id: cachedUser?.id?.toString() ?? '1',
      fullName: name.isNotEmpty ? name : 'Doctor',
      email: email,
      phone: phone,
      specialty: 'Doctor',
      imageUrl: image,
      clinics: const [],
      services: const [],
      paymentDetails: const PaymentDetailsModel(paymentType: 'bank_transfer'),
    );
  }

  Future<void> _onLoadProfile(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.status == ProfileStatus.loading) return;

    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));

    try {
      final response = await getProfileUseCase();
      var profileModel = response.toProfileModel();
      profileModel = _enrichWithCachedUser(profileModel);
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profileModel,
          errorMessage: null,
        ),
      );
    } catch (e) {
      final profileModel = _enrichWithCachedUser(null);
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profileModel,
          errorMessage: null,
        ),
      );
    }
  }

  void _onSwitchTab(SwitchTabEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(isProfileTabSelected: event.isProfile));
  }

  Future<void> _onToggleService(
    ToggleServiceEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.profile == null) return;

    final updatedServices = state.profile!.services.map((s) {
      if (s.id == event.serviceId) {
        return s.copyWith(isEnabled: event.isEnabled);
      }
      return s;
    }).toList();

    final updatedProfile = state.profile!.copyWith(services: updatedServices);
    emit(state.copyWith(profile: updatedProfile));

    try {
      await profileRepository.updateServices(updatedServices);
    } catch (_) {
      // Ignored for instant toggle
    }
  }

  Future<void> _onUpdateServicePrice(
    UpdateServicePriceEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.profile == null) return;

    final updatedServices = state.profile!.services.map((s) {
      if (s.id == event.serviceId) {
        return s.copyWith(price: event.newPrice);
      }
      return s;
    }).toList();

    final updatedProfile = state.profile!.copyWith(services: updatedServices);
    emit(state.copyWith(profile: updatedProfile));

    try {
      await profileRepository.updateServices(updatedServices);
    } catch (_) {}
  }

  Future<void> _onSaveServices(
    SaveServicesEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.profile == null) return;
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    try {
      await profileRepository.updateServices(state.profile!.services);
      emit(state.copyWith(status: ProfileStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        errorMessage: e.toString(),
      ));
    }
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

  Future<void> _onSavePaymentDetails(
    SavePaymentDetailsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    try {
      await profileRepository.updatePaymentDetails(event.paymentDetails);
      final updatedProfile = state.profile?.copyWith(
        paymentDetails: event.paymentDetails,
      );
      emit(state.copyWith(
        status: ProfileStatus.success,
        profile: updatedProfile,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onDeleteClinic(DeleteClinicEvent event, Emitter<ProfileState> emit) {
    if (state.profile == null) return;

    final updatedClinics = state.profile!.clinics
        .where((c) => c.id != event.clinicId)
        .toList();
    final updatedProfile = state.profile!.copyWith(clinics: updatedClinics);

    emit(state.copyWith(profile: updatedProfile));
  }

  Future<void> _onAddClinic(
    AddClinicSubmittedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    try {
      final clinicId = await profileRepository.addClinic(event.clinic);
      final newClinic = event.clinic.copyWith(
        id: clinicId.isNotEmpty ? clinicId : event.clinic.id,
      );
      final updatedClinics = [...?state.profile?.clinics, newClinic];
      emit(state.copyWith(
        status: ProfileStatus.success,
        profile: state.profile?.copyWith(clinics: updatedClinics),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateClinic(
    UpdateClinicSubmittedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    try {
      await profileRepository.updateClinic(event.clinicId, event.data);
      emit(state.copyWith(status: ProfileStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateProfileDetails(
    UpdateProfileDetailsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    try {
      await profileRepository.updateProfile(event.data);
    } catch (_) {
      // Allow local update to proceed even if endpoint is simulated
    }

    final cachedUser = UserHiveHelper.getUser() ?? UserData();
    if (event.data['name'] != null || event.data['full_name'] != null) {
      cachedUser.name = (event.data['name'] ?? event.data['full_name'])?.toString();
    }
    if (event.data['email'] != null) {
      cachedUser.email = event.data['email']?.toString();
    }
    if (event.data['phone'] != null || event.data['phone_number'] != null) {
      cachedUser.phone = (event.data['phone'] ?? event.data['phone_number'])?.toString();
    }
    UserHiveHelper.saveUser(cachedUser);

    final updatedProfile = state.profile?.copyWith(
      fullName: (event.data['name'] ?? event.data['full_name'])?.toString() ?? state.profile?.fullName,
      email: event.data['email']?.toString() ?? state.profile?.email,
      phone: (event.data['phone'] ?? event.data['phone_number'])?.toString() ?? state.profile?.phone,
    );

    emit(state.copyWith(
      status: ProfileStatus.success,
      profile: updatedProfile,
    ));
  }

  Future<void> _onLoadSettings(
    LoadSettingsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      final settings = await profileRepository.getSettings();
      emit(state.copyWith(settings: settings));
    } catch (_) {}
  }

  Future<void> _onToggleSetting(
    ToggleSettingEvent event,
    Emitter<ProfileState> emit,
  ) async {
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

    try {
      await profileRepository.updateSettings(updatedSettings);
    } catch (_) {}
  }

  Future<void> _onSaveSettings(
    SaveSettingsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    try {
      await profileRepository.updateSettings(event.settings);
      emit(state.copyWith(
        status: ProfileStatus.success,
        settings: event.settings,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
