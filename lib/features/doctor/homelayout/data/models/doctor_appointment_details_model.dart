import 'dart:convert';

import 'package:equatable/equatable.dart';

class DoctorAppointmentDetailsModel extends Equatable {
  final String id;
  final String? bookingId;
  final String? patientId;
  final String? providerId;
  final AppointmentPatientModel? patient;
  final String? appointmentDate;
  final String appointmentTime;
  final String serviceType;
  final String visitType;
  final String status;
  final String? paymentStatus;
  final String? paymentMethod;
  final String? feeOriginal;
  final String? feeCurrent;
  final num? totalPrice;
  final String? notes;
  final List<String> attachments;
  final String? address;
  final AppointmentConsultationModel? consultation;

  List<String> get medicalNotesImages =>
      consultation?.medicalNotesImages ?? const [];

  const DoctorAppointmentDetailsModel({
    required this.id,
    this.bookingId,
    this.patientId,
    this.providerId,
    this.patient,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.serviceType,
    required this.visitType,
    required this.status,
    this.paymentStatus,
    this.paymentMethod,
    this.feeOriginal,
    this.feeCurrent,
    this.totalPrice,
    this.notes,
    this.attachments = const [],
    this.address,
    this.consultation,
  });

  factory DoctorAppointmentDetailsModel.fromJson(Map<String, dynamic> json) {
    AppointmentPatientModel? parsedPatient;
    if (json['patient'] is Map<String, dynamic>) {
      parsedPatient = AppointmentPatientModel.fromJson(
        json['patient'] as Map<String, dynamic>,
      );
    } else if (json['user'] is Map<String, dynamic>) {
      parsedPatient = AppointmentPatientModel.fromJson(
        json['user'] as Map<String, dynamic>,
      );
    }

    AppointmentConsultationModel? parsedConsultation;
    if (json['consultation'] is Map<String, dynamic>) {
      parsedConsultation = AppointmentConsultationModel.fromJson(
        json['consultation'] as Map<String, dynamic>,
      );
    } else if (json['medical_notes_images'] != null ||
        json['medicalNotesImages'] != null) {
      parsedConsultation = AppointmentConsultationModel.fromJson(json);
    }

    final rawAttachments = json['attachments'];
    final List<String> parsedAttachments = [];
    if (rawAttachments is List) {
      for (final item in rawAttachments) {
        if (item is String && item.isNotEmpty) {
          parsedAttachments.add(item);
        } else if (item is Map && item['url'] != null) {
          parsedAttachments.add(item['url'].toString());
        } else if (item != null) {
          parsedAttachments.add(item.toString());
        }
      }
    }

    num? parsedTotalPrice;
    final rawTotal = json['total_price'] ?? json['totalPrice'];
    if (rawTotal is num) {
      parsedTotalPrice = rawTotal;
    } else if (rawTotal != null) {
      parsedTotalPrice = num.tryParse(rawTotal.toString());
    }

    return DoctorAppointmentDetailsModel(
      id: (json['id'] ?? json['booking_id'] ?? '').toString(),
      bookingId: json['booking_id']?.toString(),
      patientId: json['patient_id']?.toString(),
      providerId: json['provider_id']?.toString(),
      patient: parsedPatient,
      appointmentDate:
          (json['appointmentDate'] ??
                  json['appointment_date'] ??
                  json['date'] ??
                  '')
              .toString(),
      appointmentTime:
          (json['appointmentTime'] ??
                  json['appointment_time'] ??
                  json['time'] ??
                  '')
              .toString(),
      serviceType: (json['service_type'] ?? json['type'] ?? '').toString(),
      visitType: (json['visit_type'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      paymentStatus: json['payment_status']?.toString(),
      paymentMethod: json['payment_method']?.toString(),
      feeOriginal: json['fee_original']?.toString(),
      feeCurrent: json['fee_current']?.toString(),
      totalPrice: parsedTotalPrice,
      notes: json['notes']?.toString(),
      attachments: parsedAttachments,
      address: json['address'] is Map
          ? (json['address']['formatted'] ??
                    json['address']['address'] ??
                    json['address'].toString())
                .toString()
          : json['address']?.toString(),
      consultation: parsedConsultation,
    );
  }

  DoctorAppointmentDetailsModel copyWith({
    String? id,
    String? bookingId,
    String? patientId,
    String? providerId,
    AppointmentPatientModel? patient,
    String? appointmentDate,
    String? appointmentTime,
    String? serviceType,
    String? visitType,
    String? status,
    String? paymentStatus,
    String? paymentMethod,
    String? feeOriginal,
    String? feeCurrent,
    num? totalPrice,
    String? notes,
    List<String>? attachments,
    String? address,
    AppointmentConsultationModel? consultation,
  }) {
    return DoctorAppointmentDetailsModel(
      id: id ?? this.id,
      bookingId: bookingId ?? this.bookingId,
      patientId: patientId ?? this.patientId,
      providerId: providerId ?? this.providerId,
      patient: patient ?? this.patient,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      serviceType: serviceType ?? this.serviceType,
      visitType: visitType ?? this.visitType,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      feeOriginal: feeOriginal ?? this.feeOriginal,
      feeCurrent: feeCurrent ?? this.feeCurrent,
      totalPrice: totalPrice ?? this.totalPrice,
      notes: notes ?? this.notes,
      attachments: attachments ?? this.attachments,
      address: address ?? this.address,
      consultation: consultation ?? this.consultation,
    );
  }

  @override
  List<Object?> get props => [
    id,
    bookingId,
    patientId,
    providerId,
    patient,
    appointmentDate,
    appointmentTime,
    serviceType,
    visitType,
    status,
    paymentStatus,
    paymentMethod,
    feeOriginal,
    feeCurrent,
    totalPrice,
    notes,
    attachments,
    address,
    consultation,
  ];
}

class AppointmentPatientModel extends Equatable {
  final String id;
  final String name;
  final String? phone;
  final int? age;
  final String? gender;
  final String? avatar;

  const AppointmentPatientModel({
    required this.id,
    required this.name,
    this.phone,
    this.age,
    this.gender,
    this.avatar,
  });

  factory AppointmentPatientModel.fromJson(Map<String, dynamic> json) {
    int? parsedAge;
    final rawAge = json['age'];
    if (rawAge is int) {
      parsedAge = rawAge;
    } else if (rawAge != null) {
      parsedAge = int.tryParse(rawAge.toString());
    }

    return AppointmentPatientModel(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? json['full_name'] ?? '').toString(),
      phone: json['phone']?.toString(),
      age: parsedAge,
      gender: json['gender']?.toString(),
      avatar: json['avatar']?.toString(),
    );
  }

  @override
  List<Object?> get props => [id, name, phone, age, gender, avatar];
}

class AppointmentConsultationModel extends Equatable {
  final String? diagnosis;
  final String? medicationDetails;
  final String? laboratoryTests;
  final String? radiologyTests;
  final String? followUpDate;
  final String? prescriptionPdf;
  final List<String> medicalNotesImages;
  final String? laboratoryTestsDocument;
  final String? radiologyTestsDocument;

  const AppointmentConsultationModel({
    this.diagnosis,
    this.medicationDetails,
    this.laboratoryTests,
    this.radiologyTests,
    this.followUpDate,
    this.prescriptionPdf,
    this.medicalNotesImages = const [],
    this.laboratoryTestsDocument,
    this.radiologyTestsDocument,
  });

  factory AppointmentConsultationModel.fromJson(Map<String, dynamic> json) {
    final rawImages =
        json['medical_notes_images'] ?? json['medicalNotesImages'];
    final List<String> images = [];
    if (rawImages is List) {
      for (final img in rawImages) {
        if (img is String && img.isNotEmpty) {
          images.add(img);
        } else if (img is Map && img['url'] != null) {
          images.add(img['url'].toString());
        }
      }
    } else if (rawImages is String && rawImages.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawImages);
        if (decoded is List) {
          for (final img in decoded) {
            if (img is String && img.isNotEmpty) {
              images.add(img);
            } else if (img is Map && img['url'] != null) {
              images.add(img['url'].toString());
            }
          }
        }
      } catch (_) {}
    }

    return AppointmentConsultationModel(
      diagnosis: json['diagnosis']?.toString(),
      medicationDetails:
          (json['medication_details'] ??
                  json['medicationDetails'] ??
                  json['medications'])
              ?.toString(),
      laboratoryTests: (json['laboratory_tests'] ?? json['laboratoryTests'])
          ?.toString(),
      radiologyTests: (json['radiology_tests'] ?? json['radiologyTests'])
          ?.toString(),
      followUpDate: (json['follow_up_date'] ?? json['followUpDate'])
          ?.toString(),
      prescriptionPdf: (json['prescription_pdf'] ?? json['prescriptionPdf'])
          ?.toString(),
      medicalNotesImages: images,
      laboratoryTestsDocument:
          (json['laboratory_tests_document'] ?? json['laboratoryTestsDocument'])
              ?.toString(),
      radiologyTestsDocument:
          (json['radiology_tests_document'] ?? json['radiologyTestsDocument'])
              ?.toString(),
    );
  }

  @override
  List<Object?> get props => [
    diagnosis,
    medicationDetails,
    laboratoryTests,
    radiologyTests,
    followUpDate,
    prescriptionPdf,
    medicalNotesImages,
    laboratoryTestsDocument,
    radiologyTestsDocument,
  ];
}
