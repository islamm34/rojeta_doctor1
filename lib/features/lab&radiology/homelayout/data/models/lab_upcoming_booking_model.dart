import 'package:equatable/equatable.dart';

class LabUpcomingBookingModel extends Equatable {
  final String patientName;
  final String testCategory;
  final String appointmentTime;
  final String appointmentDate;

  const LabUpcomingBookingModel({
    required this.patientName,
    required this.testCategory,
    required this.appointmentTime,
    required this.appointmentDate,
  });

  factory LabUpcomingBookingModel.fromJson(Map<String, dynamic> json) {
    return LabUpcomingBookingModel(
      patientName: json['patientName'] ?? '',
      testCategory: json['testCategory'] ?? '',
      appointmentTime: json['appointmentTime'] ?? '',
      appointmentDate: json['appointmentDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'testCategory': testCategory,
      'appointmentTime': appointmentTime,
      'appointmentDate': appointmentDate,
    };
  }

  @override
  List<Object?> get props => [patientName, testCategory, appointmentTime, appointmentDate];
}
