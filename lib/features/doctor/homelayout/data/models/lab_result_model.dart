import 'package:equatable/equatable.dart';

class LabResultModel extends Equatable {
  final String id;
  final DateTime date;
  final String testsPerformed;
  final String results;
  final String notes;
  final bool isNormal;

  const LabResultModel({
    required this.id,
    required this.date,
    required this.testsPerformed,
    required this.results,
    required this.notes,
    required this.isNormal,
  });

  factory LabResultModel.fromJson(Map<String, dynamic> json) {
    return LabResultModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      testsPerformed: json['testsPerformed'] as String,
      results: json['results'] as String,
      notes: json['notes'] as String,
      isNormal: json['isNormal'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'testsPerformed': testsPerformed,
      'results': results,
      'notes': notes,
      'isNormal': isNormal,
    };
  }

  @override
  List<Object?> get props => [
        id,
        date,
        testsPerformed,
        results,
        notes,
        isNormal,
      ];
}
