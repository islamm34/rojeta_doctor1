import 'package:equatable/equatable.dart';

enum MedicalConsultationStatus { initial, loading, success, failure }

class MedicalConsultationState extends Equatable {
  final MedicalConsultationStatus status;
  final String? errorMessage;

  const MedicalConsultationState({
    this.status = MedicalConsultationStatus.initial,
    this.errorMessage,
  });

  MedicalConsultationState copyWith({
    MedicalConsultationStatus? status,
    String? errorMessage,
  }) {
    return MedicalConsultationState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
