import 'package:equatable/equatable.dart';
import '../../../data/models/patient_model.dart';
import '../../../data/models/patient_details_model.dart';

enum PatientsStatus { initial, loading, success, failure }

class PatientsState extends Equatable {
  final PatientsStatus status;
  final List<PatientModel> patients;
  final PatientDetailsModel? selectedPatient;
  final String? errorMessage;

  const PatientsState({
    this.status = PatientsStatus.initial,
    this.patients = const [],
    this.selectedPatient,
    this.errorMessage,
  });

  PatientsState copyWith({
    PatientsStatus? status,
    List<PatientModel>? patients,
    PatientDetailsModel? selectedPatient,
    String? errorMessage,
  }) {
    return PatientsState(
      status: status ?? this.status,
      patients: patients ?? this.patients,
      selectedPatient: selectedPatient ?? this.selectedPatient,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        patients,
        selectedPatient,
        errorMessage,
      ];
}
