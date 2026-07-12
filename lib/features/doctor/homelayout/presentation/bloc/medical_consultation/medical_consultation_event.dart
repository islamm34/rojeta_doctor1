import 'package:equatable/equatable.dart';
import '../../../data/models/consultation_request_model.dart';

abstract class MedicalConsultationEvent extends Equatable {
  const MedicalConsultationEvent();

  @override
  List<Object?> get props => [];
}

class SubmitConsultationEvent extends MedicalConsultationEvent {
  final ConsultationRequestModel request;

  const SubmitConsultationEvent(this.request);

  @override
  List<Object?> get props => [request];
}
