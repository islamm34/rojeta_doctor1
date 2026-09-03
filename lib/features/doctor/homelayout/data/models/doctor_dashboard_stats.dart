import 'package:equatable/equatable.dart';

class DoctorDashboardStats extends Equatable {
  final int todayAppointments;
  final int pendingRequests;
  final int completedAppointments;
  final int newRequests;
  final double rating;
  final String totalEarnings;

  const DoctorDashboardStats({
    required this.todayAppointments,
    required this.pendingRequests,
    required this.completedAppointments,
    required this.newRequests,
    required this.rating,
    required this.totalEarnings,
  });

  factory DoctorDashboardStats.fromJson(Map<String, dynamic> json) {
    return DoctorDashboardStats(
      todayAppointments: (json['todayAppointments'] as num?)?.toInt() ?? 0,
      pendingRequests: (json['pendingRequests'] as num?)?.toInt() ?? 0,
      completedAppointments:
          (json['completedAppointments'] as num?)?.toInt() ?? 0,
      newRequests: (json['newRequests'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalEarnings: json['totalEarnings']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todayAppointments': todayAppointments,
      'pendingRequests': pendingRequests,
      'completedAppointments': completedAppointments,
      'newRequests': newRequests,
      'rating': rating,
      'totalEarnings': totalEarnings,
    };
  }

  DoctorDashboardStats copyWith({
    int? todayAppointments,
    int? pendingRequests,
    int? completedAppointments,
    int? newRequests,
    double? rating,
    String? totalEarnings,
  }) {
    return DoctorDashboardStats(
      todayAppointments: todayAppointments ?? this.todayAppointments,
      pendingRequests: pendingRequests ?? this.pendingRequests,
      completedAppointments:
          completedAppointments ?? this.completedAppointments,
      newRequests: newRequests ?? this.newRequests,
      rating: rating ?? this.rating,
      totalEarnings: totalEarnings ?? this.totalEarnings,
    );
  }

  @override
  List<Object?> get props => [
        todayAppointments,
        pendingRequests,
        completedAppointments,
        newRequests,
        rating,
        totalEarnings,
      ];
}
