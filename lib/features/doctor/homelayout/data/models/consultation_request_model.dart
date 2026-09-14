import 'package:dio/dio.dart';

class ConsultationRequestModel {
  final int appointmentId;
  final String? diagnosis;
  final String? medicationDetails;
  final String? laboratoryTests;
  final String? radiologyTests;
  final String? followUpDate;
  final String? prescriptionPdfPath;
  final List<String>? medicalNotesImagePaths;
  final String? laboratoryTestsDocumentPath;
  final String? radiologyTestsDocumentPath;

  ConsultationRequestModel({
    required this.appointmentId,
    this.diagnosis,
    this.medicationDetails,
    this.laboratoryTests,
    this.radiologyTests,
    this.followUpDate,
    this.prescriptionPdfPath,
    this.medicalNotesImagePaths,
    this.laboratoryTestsDocumentPath,
    this.radiologyTestsDocumentPath,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'appointment_id': appointmentId};
    if (diagnosis != null && diagnosis!.trim().isNotEmpty) {
      data['diagnosis'] = diagnosis!.trim();
    }
    if (medicationDetails != null && medicationDetails!.trim().isNotEmpty) {
      data['medication_details'] = medicationDetails!.trim();
    }
    if (laboratoryTests != null && laboratoryTests!.trim().isNotEmpty) {
      data['laboratory_tests'] = laboratoryTests!.trim();
    }
    if (radiologyTests != null && radiologyTests!.trim().isNotEmpty) {
      data['radiology_tests'] = radiologyTests!.trim();
    }
    if (followUpDate != null && followUpDate!.trim().isNotEmpty) {
      data['follow_up_date'] = followUpDate!.trim();
    }
    return data;
  }

  Future<FormData> toFormData() async {
    final Map<String, dynamic> data = toJson();
    final FormData formData = FormData.fromMap(data);

    if (prescriptionPdfPath != null && prescriptionPdfPath!.isNotEmpty) {
      formData.files.add(
        MapEntry(
          'prescription_pdf',
          await MultipartFile.fromFile(
            prescriptionPdfPath!,
            filename: prescriptionPdfPath!.split('/').last,
          ),
        ),
      );
    }

    if (laboratoryTestsDocumentPath != null &&
        laboratoryTestsDocumentPath!.isNotEmpty) {
      formData.files.add(
        MapEntry(
          'laboratory_tests_document',
          await MultipartFile.fromFile(
            laboratoryTestsDocumentPath!,
            filename: laboratoryTestsDocumentPath!.split('/').last,
          ),
        ),
      );
    }

    if (radiologyTestsDocumentPath != null &&
        radiologyTestsDocumentPath!.isNotEmpty) {
      formData.files.add(
        MapEntry(
          'radiology_tests_document',
          await MultipartFile.fromFile(
            radiologyTestsDocumentPath!,
            filename: radiologyTestsDocumentPath!.split('/').last,
          ),
        ),
      );
    }

    if (medicalNotesImagePaths != null && medicalNotesImagePaths!.isNotEmpty) {
      for (final path in medicalNotesImagePaths!) {
        if (path.trim().isNotEmpty) {
          formData.files.add(
            MapEntry(
              'medical_notes_images[]',
              await MultipartFile.fromFile(
                path.trim(),
                filename: path.trim().split('/').last,
              ),
            ),
          );
        }
      }
    }

    return formData;
  }
}
