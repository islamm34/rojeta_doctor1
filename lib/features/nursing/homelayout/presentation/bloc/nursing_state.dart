import 'package:equatable/equatable.dart';
import '../../data/models/nursing_dashboard_model.dart';
import '../../data/models/nursing_service_model.dart';
import '../../data/models/nursing_staff_model.dart';
import '../../data/models/nursing_profile_model.dart';

enum NursingStatus { initial, loading, success, failure }

class NursingState extends Equatable {
  final NursingStatus status;
  final int currentTabIndex;
  final NursingDashboardModel? dashboardData;
  final List<NursingServiceModel> services;
  final List<NursingStaffModel> staff;
  final NursingStaffStatsModel? staffStats;
  final NursingProfileModel? profile;
  final NursingOfficeInfoModel? officeInfo;
  final NursingWorkingHoursModel? workingHours;
  final NursingSettingsModel? settings;
  final String? errorMessage;

  const NursingState({
    this.status = NursingStatus.initial,
    this.currentTabIndex = 0,
    this.dashboardData,
    this.services = const [
      
    ],
    this.staff = const [],
    this.staffStats,
    this.profile,
    this.officeInfo,
    this.workingHours,
    this.settings,
    this.errorMessage,
  });

  NursingState copyWith({
    NursingStatus? status,
    int? currentTabIndex,
    NursingDashboardModel? dashboardData,
    List<NursingServiceModel>? services,
    List<NursingStaffModel>? staff,
    NursingStaffStatsModel? staffStats,
    NursingProfileModel? profile,
    NursingOfficeInfoModel? officeInfo,
    NursingWorkingHoursModel? workingHours,
    NursingSettingsModel? settings,
    String? errorMessage,
  }) {
    return NursingState(
      status: status ?? this.status,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      dashboardData: dashboardData ?? this.dashboardData,
      services: services ?? this.services,
      staff: staff ?? this.staff,
      staffStats: staffStats ?? this.staffStats,
      profile: profile ?? this.profile,
      officeInfo: officeInfo ?? this.officeInfo,
      workingHours: workingHours ?? this.workingHours,
      settings: settings ?? this.settings,
      errorMessage: status == NursingStatus.failure
          ? errorMessage
          : (status == NursingStatus.loading ? null : this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    status,
    currentTabIndex,
    dashboardData,
    services,
    staff,
    staffStats,
    profile,
    officeInfo,
    workingHours,
    settings,
    errorMessage,
  ];
}
