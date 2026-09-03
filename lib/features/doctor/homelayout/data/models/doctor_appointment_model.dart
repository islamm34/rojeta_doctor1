import 'package:equatable/equatable.dart';

class DoctorAppointmentModel extends Equatable {
  final String id;
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
    return DoctorAppointmentModel(
      id: json['id']?.toString() ?? '',
      patientName: json['patientName'] as String? ?? '',
      patientAge: json['patientAge']?.toString() ?? '',
      patientGender: json['patientGender'] as String? ?? '',
      appointmentTime: json['appointmentTime'] as String? ?? '',
      appointmentDate: json['appointmentDate'] as String? ?? '',
      type: json['type'] as String? ?? '',
      status: json['status'] as String? ?? '',
      patientPhone: json['patientPhone'] as String?,
      isUrgent: json['isUrgent'] as bool? ?? false,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      feeOriginal: json['feeOriginal']?.toString(),
      feeCurrent: json['feeCurrent']?.toString(),
      discount: json['discount']?.toString(),
      paymentMethod: json['paymentMethod'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
