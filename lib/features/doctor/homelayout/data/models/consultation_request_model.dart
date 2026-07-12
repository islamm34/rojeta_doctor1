import 'package:dio/dio.dart';

class ConsultationRequestModel {
  final int appointmentId;
  final String? diagnosis;
  final String? medicationDetails;
  final String? laboratoryTests;
  final String? radiologyTests;
  final String? followUpDate;
  final String? prescriptionPdfPath;

  ConsultationRequestModel({
    required this.appointmentId,
    this.diagnosis,
    this.medicationDetails,
    this.laboratoryTests,
    this.radiologyTests,
    this.followUpDate,
    this.prescriptionPdfPath,
  });

  Map<String, dynamic> toJson() {
    return {
      'appointment_id': appointmentId,
      'diagnosis': diagnosis,
      'medication_details': medicationDetails,
      'laboratory_tests': laboratoryTests,
      'radiology_tests': radiologyTests,
      'follow_up_date': followUpDate,
    };
  }

  Future<FormData> toFormData() async {
    final Map<String, dynamic> data = toJson();
    if (prescriptionPdfPath != null) {
      data['prescription_pdf'] = await MultipartFile.fromFile(prescriptionPdfPath!);
    }
    return FormData.fromMap(data);
  }
}
