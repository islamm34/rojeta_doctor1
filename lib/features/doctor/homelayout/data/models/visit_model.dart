import 'package:equatable/equatable.dart';

class VisitModel extends Equatable {
  final String id;
  final DateTime date;
  final String type;
  final String diagnosis;
  final String prescription;
  final String notes;
  final DateTime followUpDate;

  const VisitModel({
    required this.id,
    required this.date,
    required this.type,
    required this.diagnosis,
    required this.prescription,
    required this.notes,
    required this.followUpDate,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      type: json['type'] as String,
      diagnosis: json['diagnosis'] as String,
      prescription: json['prescription'] as String,
      notes: json['notes'] as String,
      followUpDate: DateTime.parse(json['followUpDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'type': type,
      'diagnosis': diagnosis,
      'prescription': prescription,
      'notes': notes,
      'followUpDate': followUpDate.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        date,
        type,
        diagnosis,
        prescription,
        notes,
        followUpDate,
      ];
}
