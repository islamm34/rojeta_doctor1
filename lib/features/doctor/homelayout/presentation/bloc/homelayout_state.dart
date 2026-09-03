import 'package:equatable/equatable.dart';
import '../../data/models/doctor_appointment_model.dart';
import '../../data/models/doctor_dashboard_stats.dart';
import '../../data/models/doctor_profile_model.dart';

enum HomelayoutStatus { initial, loading, success, failure }

class HomelayoutState extends Equatable {
  final HomelayoutStatus status;
  final DoctorDashboardStats? stats;
  final DoctorProfileModel? profileSummary;
  final List<DoctorAppointmentModel> upcomingAppointments;
  final String? errorMessage;

  const HomelayoutState({
    this.status = HomelayoutStatus.initial,
    this.stats,
    this.profileSummary,
    this.upcomingAppointments = const [],
    this.errorMessage,
  });

  HomelayoutState copyWith({
    HomelayoutStatus? status,
    DoctorDashboardStats? stats,
    DoctorProfileModel? profileSummary,
    List<DoctorAppointmentModel>? upcomingAppointments,
    String? errorMessage,
  }) {
    return HomelayoutState(
      status: status ?? this.status,
      stats: stats ?? this.stats,
      profileSummary: profileSummary ?? this.profileSummary,
      upcomingAppointments: upcomingAppointments ?? this.upcomingAppointments,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        stats,
        profileSummary,
        upcomingAppointments,
        errorMessage,
      ];
}
