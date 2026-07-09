class DoctorAppointmentModel {
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
}
