import 'dart:convert';

class ConsultationDraftModel {
  final String appointmentId;
  final String? diagnosis;
  final String? medicationDetails;
  final String? laboratoryTests;
  final String? radiologyTests;
  final String? followUpDate;
  final bool isConsultationStarted;
  final String? prescriptionPdfPath;
  final String? prescriptionPdfName;
  final String? laboratoryTestsDocumentPath;
  final String? laboratoryTestsDocumentName;
  final String? radiologyTestsDocumentPath;
  final String? radiologyTestsDocumentName;
  final List<String> medicalNotesImagePaths;
  final DateTime? savedAt;

  const ConsultationDraftModel({
    required this.appointmentId,
    this.diagnosis,
    this.medicationDetails,
    this.laboratoryTests,
    this.radiologyTests,
    this.followUpDate,
    this.isConsultationStarted = false,
    this.prescriptionPdfPath,
    this.prescriptionPdfName,
    this.laboratoryTestsDocumentPath,
    this.laboratoryTestsDocumentName,
    this.radiologyTestsDocumentPath,
    this.radiologyTestsDocumentName,
    this.medicalNotesImagePaths = const [],
    this.savedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'appointment_id': appointmentId,
      'diagnosis': diagnosis,
      'medication_details': medicationDetails,
      'laboratory_tests': laboratoryTests,
      'radiology_tests': radiologyTests,
      'follow_up_date': followUpDate,
      'is_consultation_started': isConsultationStarted,
      'prescription_pdf_path': prescriptionPdfPath,
      'prescription_pdf_name': prescriptionPdfName,
      'laboratory_tests_document_path': laboratoryTestsDocumentPath,
      'laboratory_tests_document_name': laboratoryTestsDocumentName,
      'radiology_tests_document_path': radiologyTestsDocumentPath,
      'radiology_tests_document_name': radiologyTestsDocumentName,
      'medical_notes_image_paths': medicalNotesImagePaths,
      'saved_at': savedAt?.toIso8601String(),
    };
  }

  factory ConsultationDraftModel.fromMap(Map<String, dynamic> map) {
    return ConsultationDraftModel(
      appointmentId: map['appointment_id']?.toString() ?? '',
      diagnosis: map['diagnosis'] as String?,
      medicationDetails: map['medication_details'] as String?,
      laboratoryTests: map['laboratory_tests'] as String?,
      radiologyTests: map['radiology_tests'] as String?,
      followUpDate: map['follow_up_date'] as String?,
      isConsultationStarted: map['is_consultation_started'] as bool? ?? false,
      prescriptionPdfPath: map['prescription_pdf_path'] as String?,
      prescriptionPdfName: map['prescription_pdf_name'] as String?,
      laboratoryTestsDocumentPath:
          map['laboratory_tests_document_path'] as String?,
      laboratoryTestsDocumentName:
          map['laboratory_tests_document_name'] as String?,
      radiologyTestsDocumentPath:
          map['radiology_tests_document_path'] as String?,
      radiologyTestsDocumentName:
          map['radiology_tests_document_name'] as String?,
      medicalNotesImagePaths:
          (map['medical_notes_image_paths'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      savedAt: map['saved_at'] != null
          ? DateTime.tryParse(map['saved_at'].toString())
          : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory ConsultationDraftModel.fromJson(String source) =>
      ConsultationDraftModel.fromMap(
        jsonDecode(source) as Map<String, dynamic>,
      );
}
