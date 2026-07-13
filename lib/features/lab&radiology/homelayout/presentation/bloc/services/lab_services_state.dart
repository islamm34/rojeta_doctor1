import 'package:equatable/equatable.dart';
import 'package:rojeta_doctor/features/lab&radiology/homelayout/data/models/lab_service_model.dart';

enum LabServicesStatus { initial, loading, success, failure }

class LabServicesState extends Equatable {
  final LabServicesStatus status;
  final List<LabServiceModel> services;
  final int totalActiveServices;
  final int homeVisitsAvailableCount;
  final String? errorMessage;

  const LabServicesState({
    this.status = LabServicesStatus.initial,
    this.services = const [],
    this.totalActiveServices = 0,
    this.homeVisitsAvailableCount = 0,
    this.errorMessage,
  });

  LabServicesState copyWith({
    LabServicesStatus? status,
    List<LabServiceModel>? services,
    int? totalActiveServices,
    int? homeVisitsAvailableCount,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LabServicesState(
      status: status ?? this.status,
      services: services ?? this.services,
      totalActiveServices: totalActiveServices ?? this.totalActiveServices,
      homeVisitsAvailableCount: homeVisitsAvailableCount ?? this.homeVisitsAvailableCount,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        services,
        totalActiveServices,
        homeVisitsAvailableCount,
        errorMessage,
      ];
}
