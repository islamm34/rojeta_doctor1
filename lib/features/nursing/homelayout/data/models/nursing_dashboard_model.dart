import 'package:equatable/equatable.dart';

class NursingDashboardModel extends Equatable {
  final int todaysBookings;
  final String bookingsTrend;
  final int activeNurses;
  final String activeNursesDesc;
  final double totalEarnings;
  final String earningsDesc;
  final List<NursingBookingModel> upcomingBookings;

  const NursingDashboardModel({
    required this.todaysBookings,
    required this.bookingsTrend,
    required this.activeNurses,
    required this.activeNursesDesc,
    required this.totalEarnings,
    required this.earningsDesc,
    required this.upcomingBookings,
  });

  factory NursingDashboardModel.fromJson(Map<String, dynamic> json) {
    return NursingDashboardModel(
      todaysBookings: json['todaysBookings'] ?? 0,
      bookingsTrend: json['bookingsTrend'] ?? '',
      activeNurses: json['activeNurses'] ?? 0,
      activeNursesDesc: json['activeNursesDesc'] ?? '',
      totalEarnings: (json['totalEarnings'] ?? 0.0).toDouble(),
      earningsDesc: json['earningsDesc'] ?? '',
      upcomingBookings: (json['upcomingBookings'] as List?)
              ?.map((e) => NursingBookingModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todaysBookings': todaysBookings,
      'bookingsTrend': bookingsTrend,
      'activeNurses': activeNurses,
      'activeNursesDesc': activeNursesDesc,
      'totalEarnings': totalEarnings,
      'earningsDesc': earningsDesc,
      'upcomingBookings': upcomingBookings.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        todaysBookings,
        bookingsTrend,
        activeNurses,
        activeNursesDesc,
        totalEarnings,
        earningsDesc,
        upcomingBookings,
      ];
}

class NursingBookingModel extends Equatable {
  final String dateMonth;
  final String dateDay;
  final String patientName;
  final String serviceType;
  final String time;

  const NursingBookingModel({
    required this.dateMonth,
    required this.dateDay,
    required this.patientName,
    required this.serviceType,
    required this.time,
  });

  factory NursingBookingModel.fromJson(Map<String, dynamic> json) {
    return NursingBookingModel(
      dateMonth: json['dateMonth'] ?? '',
      dateDay: json['dateDay'] ?? '',
      patientName: json['patientName'] ?? '',
      serviceType: json['serviceType'] ?? '',
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateMonth': dateMonth,
      'dateDay': dateDay,
      'patientName': patientName,
      'serviceType': serviceType,
      'time': time,
    };
  }

  @override
  List<Object?> get props => [dateMonth, dateDay, patientName, serviceType, time];
}
