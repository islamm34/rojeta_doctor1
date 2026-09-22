import 'package:equatable/equatable.dart';

import '../../data/models/hospital_dashboard_model.dart';

enum HospitalStatus { initial, loading, success, failure }

class HospitalState extends Equatable {
  final HospitalStatus status;
  final HospitalDashboardModel? dashboardData;
  final String? errorMessage;

  const HospitalState({
    this.status = HospitalStatus.initial,
    this.dashboardData,
    this.errorMessage,
  });

  HospitalState copyWith({
    HospitalStatus? status,
    HospitalDashboardModel? dashboardData,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return HospitalState(
      status: status ?? this.status,
      dashboardData: dashboardData ?? this.dashboardData,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, dashboardData, errorMessage];
}
