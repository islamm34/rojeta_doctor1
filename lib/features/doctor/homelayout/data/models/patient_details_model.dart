import 'package:equatable/equatable.dart';
import 'patient_model.dart';
import 'visit_model.dart';
import 'lab_result_model.dart';

class PatientDetailsModel extends Equatable {
  final PatientModel basicInfo;
  final List<String> allergies;
  final List<String> chronicConditions;
  final List<VisitModel> visitHistory;
  final List<LabResultModel> labResults;

  const PatientDetailsModel({
    required this.basicInfo,
    required this.allergies,
    required this.chronicConditions,
    required this.visitHistory,
    required this.labResults,
  });

  factory PatientDetailsModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailsModel(
      basicInfo: PatientModel.fromJson(json['basicInfo'] as Map<String, dynamic>),
      allergies: List<String>.from(json['allergies'] as List<dynamic>),
      chronicConditions: List<String>.from(json['chronicConditions'] as List<dynamic>),
      visitHistory: (json['visitHistory'] as List<dynamic>)
          .map((e) => VisitModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      labResults: (json['labResults'] as List<dynamic>)
          .map((e) => LabResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'basicInfo': basicInfo.toJson(),
      'allergies': allergies,
      'chronicConditions': chronicConditions,
      'visitHistory': visitHistory.map((e) => e.toJson()).toList(),
      'labResults': labResults.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        basicInfo,
        allergies,
        chronicConditions,
        visitHistory,
        labResults,
      ];
}
