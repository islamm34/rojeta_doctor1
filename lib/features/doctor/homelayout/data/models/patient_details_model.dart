import 'package:equatable/equatable.dart';
import 'patient_model.dart';
import 'visit_model.dart';
import 'lab_result_model.dart';

export 'patient_model.dart';
export 'visit_model.dart';

typedef PatientBasicInfo = PatientModel;
typedef PatientVisitRecord = VisitModel;

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
    final basicJson = json['basicInfo'] is Map<String, dynamic>
        ? json['basicInfo'] as Map<String, dynamic>
        : (json['patient'] is Map<String, dynamic>
            ? json['patient'] as Map<String, dynamic>
            : json);

    final rawAllergies = json['allergies'] ?? json['patient_allergies'];
    final allergiesList = rawAllergies is List
        ? rawAllergies.map((e) => e.toString()).toList()
        : <String>[];

    final rawConditions = json['chronicConditions'] ??
        json['chronic_conditions'] ??
        json['conditions'];
    final conditionsList = rawConditions is List
        ? rawConditions.map((e) => e.toString()).toList()
        : <String>[];

    final rawVisits = json['visitHistory'] ??
        json['visit_history'] ??
        json['visits'] ??
        json['appointments'];
    final visitsList = rawVisits is List
        ? rawVisits
            .whereType<Map<String, dynamic>>()
            .map((e) => VisitModel.fromJson(e))
            .toList()
        : <VisitModel>[];

    final rawLabs = json['labResults'] ??
        json['lab_results'] ??
        json['tests'];
    final labsList = rawLabs is List
        ? rawLabs
            .whereType<Map<String, dynamic>>()
            .map((e) => LabResultModel.fromJson(e))
            .toList()
        : <LabResultModel>[];

    return PatientDetailsModel(
      basicInfo: PatientModel.fromJson(basicJson),
      allergies: allergiesList,
      chronicConditions: conditionsList,
      visitHistory: visitsList,
      labResults: labsList,
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
