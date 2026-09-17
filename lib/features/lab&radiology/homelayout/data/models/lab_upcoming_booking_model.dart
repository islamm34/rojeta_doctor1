import 'package:equatable/equatable.dart';

class LabUpcomingBookingModel extends Equatable {
  final String? id;
  final String? patientName;
  final String? testCategory;
  final String? appointmentTime;
  final String? appointmentDate;

  const LabUpcomingBookingModel({
    this.id,
    this.patientName,
    this.testCategory,
    this.appointmentTime,
    this.appointmentDate,
  });

  factory LabUpcomingBookingModel.fromJson(Map<String, dynamic> json) {
    return LabUpcomingBookingModel(
      id: (json['id'] ?? json['_id'])?.toString(),
      patientName:
          (json['patientName'] ??
                  json['patient_name'] ??
                  json['user_name'] ??
                  json['patient']?['name'])
              as String?,
      testCategory:
          (json['testCategory'] ??
                  json['test_category'] ??
                  json['category'] ??
                  json['service_name'] ??
                  json['service']?['name'])
              as String?,
      appointmentTime:
          (json['appointmentTime'] ?? json['appointment_time'] ?? json['time'])
              as String?,
      appointmentDate:
          (json['appointmentDate'] ?? json['appointment_date'] ?? json['date'])
              as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientName': patientName,
      'testCategory': testCategory,
      'appointmentTime': appointmentTime,
      'appointmentDate': appointmentDate,
    };
  }

  @override
  List<Object?> get props => [
    id,
    patientName,
    testCategory,
    appointmentTime,
    appointmentDate,
  ];
}
