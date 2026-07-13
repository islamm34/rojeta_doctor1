import 'package:equatable/equatable.dart';
import '../../domain/entities/general_settings.dart';
import '../../domain/entities/lab_profile.dart';
import '../../data/models/lab_info_model.dart';
import '../../data/models/working_hours_model.dart';

enum SettingsStatus { initial, loading, success, failure }

class SettingsState extends Equatable {
  final SettingsStatus status;
  final LabProfile? profile;
  final GeneralSettings settings;
  final LabInfoModel? labInfo;
  final WorkingHoursModel? workingHours;
  final String? errorMessage;

  const SettingsState({
    this.status = SettingsStatus.initial,
    this.profile,
    this.settings = const GeneralSettings(),
    this.labInfo,
    this.workingHours,
    this.errorMessage,
  });

  SettingsState copyWith({
    SettingsStatus? status,
    LabProfile? profile,
    GeneralSettings? settings,
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
