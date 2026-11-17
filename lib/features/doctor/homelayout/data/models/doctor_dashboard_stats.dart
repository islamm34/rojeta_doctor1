import 'package:equatable/equatable.dart';

class DoctorDashboardStats extends Equatable {
  final int todayAppointments;
  final int pendingRequests;
  final int completedAppointments;
  final int newRequests;
  final double rating;
  final String totalEarnings;
  final String todayIncome;

  const DoctorDashboardStats({
    required this.todayAppointments,
    required this.pendingRequests,
    required this.completedAppointments,
    required this.newRequests,
    required this.rating,
    required this.totalEarnings,
    this.todayIncome = '0',
  });

  factory DoctorDashboardStats.fromJson(Map<String, dynamic> json) {
    final rawTodayIncome =
        json['todayIncome'] ??
        json['today_income'] ??
        json['todays_income'] ??
        json['todayEarnings'] ??
        json['today_earnings'] ??
        json['daily_income'] ??
        json['today_revenue'] ??
        json['todayRevenue'];

    String parsedTodayIncome = '0';
    if (rawTodayIncome != null) {
      if (rawTodayIncome is num) {
        parsedTodayIncome = rawTodayIncome % 1 == 0
            ? rawTodayIncome.toInt().toString()
            : rawTodayIncome.toStringAsFixed(1);
      } else {
        final clean = rawTodayIncome.toString().replaceAll(
          RegExp(r'[^0-9.]'),
          '',
        );
        final parsed = double.tryParse(clean);
        if (parsed != null) {
          parsedTodayIncome = parsed % 1 == 0
              ? parsed.toInt().toString()
              : parsed.toStringAsFixed(1);
        } else {
          parsedTodayIncome = rawTodayIncome.toString().trim();
        }
      }
    }

    final totalEarnings =
        (json['totalEarnings'] ??
                json['total_earnings'] ??
                json['total_income'] ??
                json['totalRevenue'] ??
                '0')
            .toString();

    final todayAppointments =
        (json['todayAppointments'] ??
                json['today_appointments'] ??
                json['todays_appointments'] ??
                json['todayBookings'] ??
                json['today_bookings'] as num?)
            ?.toInt() ??
        0;

    return DoctorDashboardStats(
      todayAppointments: todayAppointments,
      pendingRequests:
          (json['pendingRequests'] ??
                  json['pending_requests'] ??
                  json['pendingBookings'] ??
                  json['pending_bookings'] as num?)
              ?.toInt() ??
          0,
      completedAppointments:
          (json['completedAppointments'] ??
                  json['completed_appointments'] ??
                  json['completed_bookings'] as num?)
              ?.toInt() ??
          0,
      newRequests:
          (json['newRequests'] ??
                  json['new_requests'] ??
                  json['new_patients'] as num?)
              ?.toInt() ??
          0,
      rating:
          (json['rating'] ?? json['average_rating'] as num?)?.toDouble() ?? 0.0,
      totalEarnings: totalEarnings,
      todayIncome: parsedTodayIncome,
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
      'todayIncome': todayIncome,
    };
  }

  DoctorDashboardStats copyWith({
    int? todayAppointments,
    int? pendingRequests,
    int? completedAppointments,
    int? newRequests,
    double? rating,
    String? totalEarnings,
    String? todayIncome,
  }) {
    return DoctorDashboardStats(
      todayAppointments: todayAppointments ?? this.todayAppointments,
      pendingRequests: pendingRequests ?? this.pendingRequests,
      completedAppointments:
          completedAppointments ?? this.completedAppointments,
      newRequests: newRequests ?? this.newRequests,
      rating: rating ?? this.rating,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      todayIncome: todayIncome ?? this.todayIncome,
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
    todayIncome,
  ];
}
