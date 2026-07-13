import 'package:equatable/equatable.dart';
import '../../data/models/lab_home_model.dart';

enum LabHomeStatus { initial, loading, success, failure }

class LabHomeState extends Equatable {
  final LabHomeStatus status;
  final LabHomeModel? dashboardData;
  final String? errorMessage;

  const LabHomeState({
    this.status = LabHomeStatus.initial,
    this.dashboardData,
    this.errorMessage,
  });

  LabHomeState copyWith({
    LabHomeStatus? status,
    LabHomeModel? dashboardData,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LabHomeState(
      status: status ?? this.status,
      dashboardData: dashboardData ?? this.dashboardData,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, dashboardData, errorMessage];
}
