import 'package:equatable/equatable.dart';
import '../../data/models/general_settings_model.dart';
import '../../data/models/lab_info_model.dart';
import '../../data/models/lab_profile_model.dart';
import '../../data/models/working_hours_model.dart';

enum SettingsStatus { initial, loading, success, failure }

class SettingsState extends Equatable {
  final SettingsStatus status;
  final LabProfileModel? profile;
  final GeneralSettingsModel settings;
  final LabInfoModel? labInfo;
  final WorkingHoursModel? workingHours;
  final String? errorMessage;

  const SettingsState({
    this.status = SettingsStatus.initial,
    this.profile,
    this.settings = const GeneralSettingsModel(),
    this.labInfo,
    this.workingHours,
    this.errorMessage,
  });

  SettingsState copyWith({
    SettingsStatus? status,
    LabProfileModel? profile,
    GeneralSettingsModel? settings,
    LabInfoModel? labInfo,
    WorkingHoursModel? workingHours,
    String? errorMessage,
  }) {
    return SettingsState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      settings: settings ?? this.settings,
      labInfo: labInfo ?? this.labInfo,
      workingHours: workingHours ?? this.workingHours,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, profile, settings, labInfo, workingHours, errorMessage];
}
