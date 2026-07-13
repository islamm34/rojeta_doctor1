import 'package:rojeta_doctor/features/hospital/medical_services/data/models/hospital_service_model.dart';
import 'package:rojeta_doctor/features/hospital/medical_services/data/models/specialty_model.dart';

enum MedicalServicesStatus { initial, loading, success, failure }

class MedicalServicesState {
  final MedicalServicesStatus status;
  final String? errorMessage;
  final bool isSetupComplete;
  final int activeSpecialtiesCount;
  final int totalStaffCount;
  final List<HospitalServiceModel> services;
  final List<SpecialtyModel> specialties;

  const MedicalServicesState({
    this.status = MedicalServicesStatus.initial,
    this.errorMessage,
    this.isSetupComplete = false,
    this.activeSpecialtiesCount = 0,
    this.totalStaffCount = 0,
    this.services = const [],
    this.specialties = const [],
  });

  MedicalServicesState copyWith({
    MedicalServicesStatus? status,
    String? errorMessage,
    bool? isSetupComplete,
    int? activeSpecialtiesCount,
    int? totalStaffCount,
    List<HospitalServiceModel>? services,
    List<SpecialtyModel>? specialties,
  }) {
    final nextStatus = status ?? this.status;
    return MedicalServicesState(
      status: nextStatus,
      errorMessage: nextStatus == MedicalServicesStatus.failure
          ? (errorMessage ?? this.errorMessage)
          : null,
      isSetupComplete: isSetupComplete ?? this.isSetupComplete,
      activeSpecialtiesCount:
          activeSpecialtiesCount ?? this.activeSpecialtiesCount,
      totalStaffCount: totalStaffCount ?? this.totalStaffCount,
      services: services ?? this.services,
      specialties: specialties ?? this.specialties,
    );
  }
}
