import '../../../data/models/profile_model.dart';
import '../../../data/models/settings_model.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState {
  final ProfileStatus status;
  final ProfileModel? profile;
  final String? errorMessage;
  // This helps us track if we are viewing "Profile" or "Settings" tab locally in UI
  final bool isProfileTabSelected;
  final SettingsModel settings;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.errorMessage,
    this.isProfileTabSelected = true,
    this.settings = const SettingsModel(),
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileModel? profile,
    String? errorMessage,
    bool? isProfileTabSelected,
    SettingsModel? settings,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage, // We don't ?? this because we want to allow nulling it
      isProfileTabSelected: isProfileTabSelected ?? this.isProfileTabSelected,
      settings: settings ?? this.settings,
    );
  }
}
