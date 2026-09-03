import 'package:equatable/equatable.dart';

abstract class PatientsEvent extends Equatable {
  const PatientsEvent();

  @override
  List<Object?> get props => [];
}

class FetchPatientsEvent extends PatientsEvent {
  const FetchPatientsEvent();
}

class SearchPatientsEvent extends PatientsEvent {
  final String query;

  const SearchPatientsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class FetchPatientDetailsEvent extends PatientsEvent {
  final String patientId;

  const FetchPatientDetailsEvent(this.patientId);

  @override
  List<Object?> get props => [patientId];
}
