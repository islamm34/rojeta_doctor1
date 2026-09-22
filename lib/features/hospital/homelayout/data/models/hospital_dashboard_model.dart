import 'package:equatable/equatable.dart';

import '../../../../doctor/homelayout/data/models/doctor_appointment_model.dart';

class HospitalDashboardModel extends Equatable {
  final int? doctorsCount;
  final double? todaysIncome;
  final int? appointmentsCount;
  final int? unreadNotificationsCount;
  final List<DoctorAppointmentModel> upcomingAppointments;

  const HospitalDashboardModel({
    this.doctorsCount,
    this.todaysIncome,
    this.appointmentsCount,
    this.unreadNotificationsCount,
    this.upcomingAppointments = const [],
  });

  factory HospitalDashboardModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const HospitalDashboardModel();

    final doctors =
        json['doctors_count'] ??
        json['doctorsCount'] ??
        json['doctors'] ??
        json['total_doctors'];

    final income =
        json['todays_income'] ??
        json['todaysIncome'] ??
        json['today_income'] ??
        json['income'] ??
        json['total_income'] ??
        json['total_revenue'];

    final appointments =
        json['appointments_count'] ??
        json['appointmentsCount'] ??
        json['appointments'] ??
        json['total_appointments'] ??
        json['todays_appointments'];

    final notifications =
        json['unread_notifications_count'] ??
        json['unreadNotificationsCount'] ??
        json['notifications_count'] ??
        json['unread_count'];

    final appointmentsRaw =
        json['upcoming_appointments'] ??
        json['upcomingAppointments'] ??
        json['upcoming'] ??
        json['appointments_list'] ??
        [];

    List<DoctorAppointmentModel> appointmentsList = [];
    if (appointmentsRaw is List) {
      appointmentsList = appointmentsRaw
          .whereType<Map<String, dynamic>>()
          .map((e) => DoctorAppointmentModel.fromJson(e))
          .toList();
    }

    return HospitalDashboardModel(
      doctorsCount: doctors is num
          ? doctors.toInt()
          : int.tryParse(doctors?.toString() ?? ''),
      todaysIncome: income is num
          ? income.toDouble()
          : double.tryParse(income?.toString() ?? ''),
      appointmentsCount: appointments is num
          ? appointments.toInt()
          : int.tryParse(appointments?.toString() ?? ''),
      unreadNotificationsCount: notifications is num
          ? notifications.toInt()
          : int.tryParse(notifications?.toString() ?? ''),
      upcomingAppointments: appointmentsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctors_count': doctorsCount,
      'todays_income': todaysIncome,
      'appointments_count': appointmentsCount,
      'unread_notifications_count': unreadNotificationsCount,
      'upcoming_appointments': upcomingAppointments
          .map((e) => e.toJson())
          .toList(),
    };
  }

  HospitalDashboardModel copyWith({
    int? doctorsCount,
    double? todaysIncome,
    int? appointmentsCount,
    int? unreadNotificationsCount,
    List<DoctorAppointmentModel>? upcomingAppointments,
  }) {
    return HospitalDashboardModel(
      doctorsCount: doctorsCount ?? this.doctorsCount,
      todaysIncome: todaysIncome ?? this.todaysIncome,
      appointmentsCount: appointmentsCount ?? this.appointmentsCount,
      unreadNotificationsCount:
          unreadNotificationsCount ?? this.unreadNotificationsCount,
      upcomingAppointments: upcomingAppointments ?? this.upcomingAppointments,
    );
  }

  @override
  List<Object?> get props => [
    doctorsCount,
    todaysIncome,
    appointmentsCount,
    unreadNotificationsCount,
    upcomingAppointments,
  ];
}
