import 'package:rojeta_doctor/core/di/injector.dart';
import '../../../data/repositories/marketing_repository.dart';
import 'package:rojeta_doctor/core/utils/flutter_secure_storage_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<GenerateDoctorQrCodeEvent>(_onGenerateDoctorQrCode);
    on<SetProStatusEvent>(_onSetProStatus);
  }

  ProfileModel _enrichWithCachedUser(ProfileModel? base) {
    final cachedUser = UserHiveHelper.getUser();
    final name = (base?.fullName.isNotEmpty == true)
        ? base!.fullName
        : (cachedUser?.name?.isNotEmpty == true
              ? cachedUser!.name!
              : '${cachedUser?.firstName ?? ''} ${cachedUser?.secondName ?? ''}'
                    .trim());
    String email = '';
    if (base != null && base.email.trim().isNotEmpty) {
      email = base.email.trim();
    } else if (cachedUser?.email != null && cachedUser!.email!.trim().isNotEmpty) {
      email = cachedUser.email!.trim();
    } else {
      final cleanName = name.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '.');
      email = cleanName.isNotEmpty && cleanName != 'doctor'
          ? '$cleanName@rojetadoctor.com'
          : 'doctor@rojetadoctor.com';
    }
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
        certificates: base.certificates,
        qrCodeData: base.qrCodeData,
      );
    }
    final docId = cachedUser?.id?.toString() ?? '1';
    final fallbackCerts = UserHiveHelper.getDoctorCertificates(docId);
    return ProfileModel(
      id: docId,
      fullName: name.isNotEmpty ? name : 'Doctor',
      email: email,
      phone: phone,
      specialty: 'Doctor',
      imageUrl: image,
      clinics: const [],
      services: const [],
      paymentDetails: const PaymentDetailsModel(paymentType: 'bank_transfer'),
      certificates: fallbackCerts,
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
      try {
        var isPro = profileModel.isPro;
        if (!isPro) {
          final isProSaved = await FlutterSecureStorageHelper.getDoctorIsPro(profileModel.id);
          if (isProSaved) {
            isPro = true;
          }
        }
        if (!isPro) {
          try {
            if (injector.isRegistered<MarketingRepository>()) {
              final activePlan = await injector<MarketingRepository>().getActivePlan();
              if (activePlan != null) {
                isPro = true;
                await FlutterSecureStorageHelper.saveDoctorIsPro(profileModel.id, true);
              }
            }
          } catch (_) {}
        }
        if (isPro) {
          profileModel = profileModel.copyWith(isPro: true);
        }
        final savedQr = await FlutterSecureStorageHelper.getDoctorQr(profileModel.id);
        if (savedQr != null && savedQr.isNotEmpty) {
          profileModel = profileModel.copyWith(qrCodeData: savedQr);
        }
        final cachedUser = UserHiveHelper.getUser();
        final userKey = cachedUser?.id?.toString() ?? cachedUser?.phone ?? profileModel.id;
        final savedImage = await FlutterSecureStorageHelper.getDoctorImage(profileModel.id) ??
            UserHiveHelper.getUserImage(userKey) ??
            UserHiveHelper.getDoctorImage(profileModel.id);
        if (savedImage != null && savedImage.trim().isNotEmpty) {
          profileModel = profileModel.copyWith(imageUrl: savedImage.trim());
          if (cachedUser != null && (cachedUser.image == null || cachedUser.image!.isEmpty)) {
            cachedUser.image = savedImage.trim();
            UserHiveHelper.saveUser(cachedUser);
          }
        }
        final savedEmail = await FlutterSecureStorageHelper.getDoctorEmail(profileModel.id);
        if (savedEmail != null && savedEmail.trim().isNotEmpty) {
          profileModel = profileModel.copyWith(email: savedEmail.trim());
        } else if (profileModel.email.trim().isNotEmpty) {
          await FlutterSecureStorageHelper.saveDoctorEmail(profileModel.id, profileModel.email.trim());
        }
        final docId = profileModel.id.isNotEmpty ? profileModel.id : (cachedUser?.id?.toString() ?? '');
        var savedCerts = await FlutterSecureStorageHelper.getDoctorCertificates(docId);
        if (savedCerts.isEmpty && cachedUser?.id != null) {
          savedCerts = await FlutterSecureStorageHelper.getDoctorCertificates(cachedUser!.id.toString());
        }
        if (savedCerts.isEmpty) {
          savedCerts = UserHiveHelper.getDoctorCertificates(docId);
          if (savedCerts.isEmpty && cachedUser?.id != null) {
            savedCerts = UserHiveHelper.getDoctorCertificates(cachedUser!.id.toString());
          }
        }
        final existingCerts = state.profile?.certificates ?? const [];
        final mergedCerts = <String>{
          ...profileModel.certificates,
          ...savedCerts,
          ...existingCerts,
        }.toList();
        if (mergedCerts.isNotEmpty) {
          profileModel = profileModel.copyWith(certificates: mergedCerts);
          if (docId.isNotEmpty) {
            await FlutterSecureStorageHelper.saveDoctorCertificates(docId, mergedCerts);
            UserHiveHelper.saveDoctorCertificates(docId, mergedCerts);
          }
        }
      } catch (_) {}
      SettingsModel? settings;
      try {
        settings = await profileRepository.getSettings();
      } catch (_) {}
      if (settings == null) {
        final cachedUser = UserHiveHelper.getUser();
        final userKey = profileModel.id.isNotEmpty ? profileModel.id : (cachedUser?.id?.toString() ?? cachedUser?.phone ?? '');
        if (userKey.isNotEmpty) {
          final cachedSettings = UserHiveHelper.getUserSettings(userKey);
          if (cachedSettings != null) {
            settings = SettingsModel.fromJson(cachedSettings);
          }
        }
      }
      if (profileModel.clinics.isNotEmpty) {
        final c = profileModel.clinics.first;
        final loc = [
          if (c.name.isNotEmpty) c.name,
          if (c.fullAddress?.isNotEmpty == true) c.fullAddress,
          if (c.city?.isNotEmpty == true) c.city,
          if (c.governorate?.isNotEmpty == true) c.governorate,
        ].join('، ');
        if (loc.isNotEmpty) {
          UserHiveHelper.saveDoctorClinicAddress(loc);
        }
      }
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profileModel,
          settings: settings ?? state.settings,
          errorMessage: null,
        ),
      );
    } catch (e) {
      var profileModel = _enrichWithCachedUser(null);
      try {
        var isPro = profileModel.isPro;
        if (!isPro) {
          final isProSaved = await FlutterSecureStorageHelper.getDoctorIsPro(profileModel.id);
          if (isProSaved) {
            isPro = true;
          }
        }
        if (isPro) {
          profileModel = profileModel.copyWith(isPro: true);
        }
        final savedQr = await FlutterSecureStorageHelper.getDoctorQr(profileModel.id);
        if (savedQr != null && savedQr.isNotEmpty) {
          profileModel = profileModel.copyWith(qrCodeData: savedQr);
        }
        final cachedUser = UserHiveHelper.getUser();
        final userKey = cachedUser?.id?.toString() ?? cachedUser?.phone ?? profileModel.id;
        final savedImage = await FlutterSecureStorageHelper.getDoctorImage(profileModel.id) ??
            UserHiveHelper.getUserImage(userKey) ??
            UserHiveHelper.getDoctorImage(profileModel.id);
        if (savedImage != null && savedImage.trim().isNotEmpty) {
          profileModel = profileModel.copyWith(imageUrl: savedImage.trim());
          if (cachedUser != null && (cachedUser.image == null || cachedUser.image!.isEmpty)) {
            cachedUser.image = savedImage.trim();
            UserHiveHelper.saveUser(cachedUser);
          }
        }
        final savedEmail = await FlutterSecureStorageHelper.getDoctorEmail(profileModel.id);
        if (savedEmail != null && savedEmail.trim().isNotEmpty) {
          profileModel = profileModel.copyWith(email: savedEmail.trim());
        } else if (profileModel.email.trim().isNotEmpty) {
          await FlutterSecureStorageHelper.saveDoctorEmail(profileModel.id, profileModel.email.trim());
        }
        final docId = profileModel.id.isNotEmpty ? profileModel.id : (cachedUser?.id?.toString() ?? '');
        var savedCerts = await FlutterSecureStorageHelper.getDoctorCertificates(docId);
        if (savedCerts.isEmpty && cachedUser?.id != null) {
          savedCerts = await FlutterSecureStorageHelper.getDoctorCertificates(cachedUser!.id.toString());
        }
        if (savedCerts.isEmpty) {
          savedCerts = UserHiveHelper.getDoctorCertificates(docId);
          if (savedCerts.isEmpty && cachedUser?.id != null) {
            savedCerts = UserHiveHelper.getDoctorCertificates(cachedUser!.id.toString());
          }
        }
        final existingCerts = state.profile?.certificates ?? const [];
        final mergedCerts = <String>{
          ...profileModel.certificates,
          ...savedCerts,
          ...existingCerts,
        }.toList();
        if (mergedCerts.isNotEmpty) {
          profileModel = profileModel.copyWith(certificates: mergedCerts);
          if (docId.isNotEmpty) {
            await FlutterSecureStorageHelper.saveDoctorCertificates(docId, mergedCerts);
            UserHiveHelper.saveDoctorCertificates(docId, mergedCerts);
          }
        }
      } catch (_) {}
      SettingsModel? settings;
      try {
        settings = await profileRepository.getSettings();
      } catch (_) {}
      if (settings == null) {
        final cachedUser = UserHiveHelper.getUser();
        final userKey = profileModel.id.isNotEmpty ? profileModel.id : (cachedUser?.id?.toString() ?? cachedUser?.phone ?? '');
        if (userKey.isNotEmpty) {
          final cachedSettings = UserHiveHelper.getUserSettings(userKey);
          if (cachedSettings != null) {
            settings = SettingsModel.fromJson(cachedSettings);
          }
        }
      }
      if (profileModel.clinics.isNotEmpty) {
        final c = profileModel.clinics.first;
        final loc = [
          if (c.name.isNotEmpty) c.name,
          if (c.fullAddress?.isNotEmpty == true) c.fullAddress,
          if (c.city?.isNotEmpty == true) c.city,
          if (c.governorate?.isNotEmpty == true) c.governorate,
        ].join('، ');
        if (loc.isNotEmpty) {
          UserHiveHelper.saveDoctorClinicAddress(loc);
        }
      }
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profileModel,
          settings: settings ?? state.settings,
          errorMessage: null,
        ),
      );
    }
  }

  Future<void> _onSwitchTab(
    SwitchTabEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isProfileTabSelected: event.isProfile));
    if (!event.isProfile) {
      try {
        final settings = await profileRepository.getSettings();
        emit(state.copyWith(settings: settings));
      } catch (_) {}
    }
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
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
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
      emit(
        state.copyWith(status: ProfileStatus.success, profile: updatedProfile),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onDeleteClinic(
    DeleteClinicEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.profile == null) return;
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    try {
      await profileRepository.deleteClinic(event.clinicId);
      final updatedClinics = state.profile!.clinics
          .where((c) => c.id != event.clinicId)
          .toList();
      final updatedProfile = state.profile!.copyWith(clinics: updatedClinics);
      emit(
        state.copyWith(status: ProfileStatus.success, profile: updatedProfile),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
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
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: state.profile?.copyWith(clinics: updatedClinics),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateClinic(
    UpdateClinicSubmittedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    try {
      await profileRepository.updateClinic(event.clinic);
      final updatedClinics = state.profile?.clinics.map((c) {
        return c.id == event.clinic.id ? event.clinic : c;
      }).toList();
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: state.profile?.copyWith(clinics: updatedClinics),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
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
      cachedUser.name = (event.data['name'] ?? event.data['full_name'])
          ?.toString();
    }
    if (event.data['email'] != null && event.data['email'].toString().trim().isNotEmpty) {
      final newEmail = event.data['email'].toString().trim();
      cachedUser.email = newEmail;
      try {
        if (state.profile != null) {
          await FlutterSecureStorageHelper.saveDoctorEmail(
            state.profile!.id,
            newEmail,
          );
        }
      } catch (_) {}
    }
    if (event.data['phone'] != null || event.data['phone_number'] != null) {
      cachedUser.phone = (event.data['phone'] ?? event.data['phone_number'])
          ?.toString();
    }
    final newImage = (event.data['imageUrl'] ??
            event.data['image_url'] ??
            event.data['image'])
        ?.toString();
    if (newImage != null && newImage.trim().isNotEmpty) {
      final cleanImg = newImage.trim();
      cachedUser.image = cleanImg;
      final docId = (state.profile?.id.isNotEmpty == true)
          ? state.profile!.id
          : (cachedUser.id?.toString() ?? '');
      final userKey = cachedUser.id?.toString() ?? cachedUser.phone ?? docId;
      UserHiveHelper.saveUserImage(userKey, cleanImg);
      UserHiveHelper.saveDoctorImage(docId, cleanImg);
      try {
        await FlutterSecureStorageHelper.saveDoctorImage(
          docId,
          cleanImg,
        );
        await FlutterSecureStorageHelper.saveUserImage(
          userKey,
          cleanImg,
        );
      } catch (_) {}
    }
    UserHiveHelper.saveUser(cachedUser);

    final certsRaw = event.data['certificates'];
    final List<String>? updatedCerts = certsRaw is List
        ? certsRaw.map((e) => e.toString()).toList()
        : (certsRaw is String ? [certsRaw] : null);

    if (updatedCerts != null) {
      final docId = (state.profile?.id.isNotEmpty == true)
          ? state.profile!.id
          : (cachedUser.id?.toString() ?? '');
      try {
        await FlutterSecureStorageHelper.saveDoctorCertificates(
          docId,
          updatedCerts,
        );
        UserHiveHelper.saveDoctorCertificates(
          docId,
          updatedCerts,
        );
      } catch (_) {}
    }


    final rawPayment =
        event.data['payment_details'] ?? event.data['paymentDetails'];
    final paymentMap =
        rawPayment is Map ? Map<String, dynamic>.from(rawPayment) : null;
    final updatedPayment =
        paymentMap != null
            ? PaymentDetailsModel.fromJson(paymentMap)
            : state.profile?.paymentDetails;

    final updatedProfile = state.profile?.copyWith(
      fullName:
          (event.data['name'] ?? event.data['full_name'])?.toString() ??
          state.profile?.fullName,
      email: event.data['email']?.toString() ?? state.profile?.email,
      phone:
          (event.data['phone'] ?? event.data['phone_number'])?.toString() ??
          state.profile?.phone,
      specialty:
          event.data['specialty']?.toString() ?? state.profile?.specialty,
      subSpecialty:
          (event.data['sub_specialty'] ?? event.data['subSpecialty'])
              ?.toString() ??
          state.profile?.subSpecialty,
      yearsOfExperience:
          (event.data['years_of_experience'] ??
                  event.data['yearsOfExperience'] ??
                  event.data['experience_years'])
              ?.toString() ??
          state.profile?.yearsOfExperience,
      about:
          (event.data['about'] ??
                  event.data['bio'] ??
                  event.data['description'])
              ?.toString() ??
          state.profile?.about,
      education:
          event.data['education']?.toString() ?? state.profile?.education,
      imageUrl:
          (event.data['imageUrl'] ??
                  event.data['image_url'] ??
                  event.data['image'])
              ?.toString() ??
          state.profile?.imageUrl,
      paymentDetails: updatedPayment,
      certificates: updatedCerts ?? state.profile?.certificates ?? const [],
    );

    emit(
      state.copyWith(status: ProfileStatus.success, profile: updatedProfile),
    );
  }


  Future<void> _onSetProStatus(
    SetProStatusEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.profile == null) return;
    try {
      await FlutterSecureStorageHelper.saveDoctorIsPro(state.profile!.id, event.isPro);
    } catch (_) {}
    emit(state.copyWith(
      profile: state.profile!.copyWith(isPro: event.isPro),
    ));
  }

  Future<void> _onGenerateDoctorQrCode(
    GenerateDoctorQrCodeEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.profile == null) return;
    final updatedProfile = state.profile!.copyWith(qrCodeData: event.qrData);
    emit(state.copyWith(profile: updatedProfile));
    try {
      await FlutterSecureStorageHelper.saveDoctorQr(
        state.profile!.id,
        event.qrData,
      );
    } catch (_) {}
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

    final cachedUser = UserHiveHelper.getUser();
    final userKey = (state.profile?.id.isNotEmpty == true)
        ? state.profile!.id
        : (cachedUser?.id?.toString() ?? cachedUser?.phone ?? '');
    if (userKey.isNotEmpty) {
      UserHiveHelper.saveUserSettings(userKey, updatedSettings.toJson());
    }

    try {
      await profileRepository.updateSettings(updatedSettings);
    } catch (_) {}
  }

  Future<void> _onSaveSettings(
    SaveSettingsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    final cachedUser = UserHiveHelper.getUser();
    final userKey = (state.profile?.id.isNotEmpty == true)
        ? state.profile!.id
        : (cachedUser?.id?.toString() ?? cachedUser?.phone ?? '');
    if (userKey.isNotEmpty) {
      UserHiveHelper.saveUserSettings(userKey, event.settings.toJson());
    }
    try {
      await profileRepository.updateSettings(event.settings);
      emit(
        state.copyWith(status: ProfileStatus.success, settings: event.settings),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
