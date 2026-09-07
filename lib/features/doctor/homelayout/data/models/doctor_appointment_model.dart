import 'package:equatable/equatable.dart';

class DoctorAppointmentModel extends Equatable {
  final String id;
  final String? patientId;
  final String patientName;
  final String patientAge;
  final String patientGender;
  final String appointmentTime;
  final String appointmentDate;
  final String type;
  final String status;
  final String? patientPhone;
  final bool isUrgent;
  final String? location;
  final String? notes;
  final String? feeOriginal;
  final String? feeCurrent;
  final String? discount;
  final String? paymentMethod;
  final bool isOnline;

  const DoctorAppointmentModel({
    required this.id,
    this.patientId,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.appointmentTime,
    required this.appointmentDate,
    required this.type,
    required this.status,
    this.patientPhone,
    this.isUrgent = false,
    this.location,
    this.notes,
    this.feeOriginal,
    this.feeCurrent,
    this.discount,
    this.paymentMethod,
    this.isOnline = false,
  });

  factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json) {
    // Nested patient object if returned by backend
    final patientObj = json['patient'] is Map<String, dynamic>
        ? json['patient'] as Map<String, dynamic>
        : (json['user'] is Map<String, dynamic>
            ? json['user'] as Map<String, dynamic>
            : null);

    final patientName = (json['patientName'] ??
            json['patient_name'] ??
            patientObj?['name'] ??
            patientObj?['full_name'] ??
            json['name'] ??
            '')
        .toString();

    final patientAge = (json['patientAge'] ??
            json['patient_age'] ??
            patientObj?['age'] ??
            '')
        .toString();

    final patientGender = (json['patientGender'] ??
            json['patient_gender'] ??
            patientObj?['gender'] ??
            '')
        .toString();

    final patientPhone = (json['patientPhone'] ??
            json['patient_phone'] ??
            patientObj?['phone'] ??
            json['phone'])
        ?.toString();

    final patientId = (json['patientId'] ??
            json['patient_id'] ??
            patientObj?['id'] ??
            json['user_id'])
        ?.toString();

    final appointmentTime = (json['appointmentTime'] ??
            json['appointment_time'] ??
            json['time'] ??
            json['booking_time'] ??
            '')
        .toString();

    final appointmentDate = (json['appointmentDate'] ??
            json['appointment_date'] ??
            json['date'] ??
            json['booking_date'] ??
            '')
        .toString();

    final type = (json['type'] ??
            json['service_type'] ??
            json['consultation_type'] ??
            '')
        .toString();

    final status = (json['status'] ?? json['booking_status'] ?? '').toString();

    final isUrgent = json['isUrgent'] == true ||
        json['is_urgent'] == true ||
        json['urgent'] == true ||
        json['is_urgent'] == 1;

    final location = (json['location'] ??
            json['clinic_address'] ??
            json['address'])
        ?.toString();

    final notes = (json['notes'] ??
            json['symptoms'] ??
            json['complaint'] ??
            json['description'])
        ?.toString();

    final feeOriginal = (json['feeOriginal'] ??
            json['fee_original'] ??
            json['original_fee'] ??
            json['fee'] ??
            json['price'] ??
            json['amount'])
        ?.toString();

    final feeCurrent = (json['feeCurrent'] ??
            json['fee_current'] ??
            json['current_fee'] ??
            json['total'] ??
            json['fee'] ??
            json['price'])
        ?.toString();

    final discount = (json['discount'] ?? json['discount_amount'])?.toString();

    final paymentMethod = (json['paymentMethod'] ??
            json['payment_method'] ??
            json['payment_type'])
        ?.toString();

    final isOnline = json['isOnline'] == true ||
        json['is_online'] == true ||
        type.toLowerCase().contains('online') ||
        type.toLowerCase().contains('video');

    return DoctorAppointmentModel(
      id: json['id']?.toString() ?? json['booking_id']?.toString() ?? '',
      patientId: patientId,
      patientName: patientName,
      patientAge: patientAge,
      patientGender: patientGender,
      appointmentTime: appointmentTime,
      appointmentDate: appointmentDate,
      type: type,
      status: status,
      patientPhone: patientPhone,
      isUrgent: isUrgent,
      location: location,
      notes: notes,
      feeOriginal: feeOriginal,
      feeCurrent: feeCurrent,
      discount: discount,
      paymentMethod: paymentMethod,
      isOnline: isOnline,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'patientName': patientName,
      'patientAge': patientAge,
      'patientGender': patientGender,
      'appointmentTime': appointmentTime,
      'appointmentDate': appointmentDate,
      'type': type,
      'status': status,
      'patientPhone': patientPhone,
      'isUrgent': isUrgent,
      'location': location,
      'notes': notes,
      'feeOriginal': feeOriginal,
      'feeCurrent': feeCurrent,
      'discount': discount,
      'paymentMethod': paymentMethod,
      'isOnline': isOnline,
    };
  }

  DoctorAppointmentModel copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? patientAge,
    String? patientGender,
    String? appointmentTime,
    String? appointmentDate,
    String? type,
    String? status,
    String? patientPhone,
    bool? isUrgent,
    String? location,
    String? notes,
    String? feeOriginal,
    String? feeCurrent,
    String? discount,
    String? paymentMethod,
    bool? isOnline,
  }) {
    return DoctorAppointmentModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      patientAge: patientAge ?? this.patientAge,
      patientGender: patientGender ?? this.patientGender,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      type: type ?? this.type,
      status: status ?? this.status,
      patientPhone: patientPhone ?? this.patientPhone,
      isUrgent: isUrgent ?? this.isUrgent,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      feeOriginal: feeOriginal ?? this.feeOriginal,
      feeCurrent: feeCurrent ?? this.feeCurrent,
      discount: discount ?? this.discount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  List<Object?> get props => [
        id,
        patientId,
        patientName,
        patientAge,
        patientGender,
        appointmentTime,
        appointmentDate,
        type,
        status,
        patientPhone,
        isUrgent,
        location,
        notes,
        feeOriginal,
        feeCurrent,
        discount,
        paymentMethod,
        isOnline,
      ];
}
