import 'package:equatable/equatable.dart';

class NursingDashboardModel extends Equatable {
  final int? todaysBookings;
  final String? bookingsTrend;
  final int? activeNurses;
  final String? activeNursesDesc;
  final double? totalEarnings;
  final String? earningsDesc;
  final List<NursingBookingModel> upcomingBookings;

  const NursingDashboardModel({
    this.todaysBookings = 0,
    this.bookingsTrend = '',
    this.activeNurses = 0,
    this.activeNursesDesc = '',
    this.totalEarnings = 0.0,
    this.earningsDesc = '',
    this.upcomingBookings = const [],
  });

  factory NursingDashboardModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingDashboardModel();

    final todays = json['todaysBookings'] ??
        json['todays_bookings'] ??
        json['today_bookings'] ??
        json['total_appointments_today'] ??
        json['todayBookingsCount'] ??
        0;

    final trend = json['bookingsTrend'] ??
        json['bookings_trend'] ??
        '+12% from yesterday';

    final activeNursesCount = json['activeNurses'] ??
        json['active_nurses'] ??
        json['nurses_count'] ??
        json['total_nurses'] ??
        0;

    final nursesDesc = json['activeNursesDesc'] ??
        json['active_nurses_desc'] ??
        'On-duty across all wards';

    final earnings = (json['totalEarnings'] ??
            json['total_earnings'] ??
            json['earnings'] ??
            json['total_revenue'] ??
            0.0)
        .toDouble();

    final earnDesc = json['earningsDesc'] ??
        json['earnings_desc'] ??
        'Monthly revenue to date';

    final bookingsRaw = json['upcomingBookings'] ??
        json['upcoming_bookings'] ??
        json['upcoming'] ??
        json['bookings'] ??
        [];

    List<NursingBookingModel> bookingsList = [];
    if (bookingsRaw is List) {
      bookingsList = bookingsRaw
          .whereType<Map<String, dynamic>>()
          .map((e) => NursingBookingModel.fromJson(e))
          .toList();
    }

    return NursingDashboardModel(
      todaysBookings: (todays is num) ? todays.toInt() : int.tryParse(todays.toString()) ?? 0,
      bookingsTrend: trend.toString(),
      activeNurses: (activeNursesCount is num)
          ? activeNursesCount.toInt()
          : int.tryParse(activeNursesCount.toString()) ?? 0,
      activeNursesDesc: nursesDesc.toString(),
      totalEarnings: earnings,
      earningsDesc: earnDesc.toString(),
      upcomingBookings: bookingsList,
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

  NursingDashboardModel copyWith({
    int? todaysBookings,
    String? bookingsTrend,
    int? activeNurses,
    String? activeNursesDesc,
    double? totalEarnings,
    String? earningsDesc,
    List<NursingBookingModel>? upcomingBookings,
  }) {
    return NursingDashboardModel(
      todaysBookings: todaysBookings ?? this.todaysBookings,
      bookingsTrend: bookingsTrend ?? this.bookingsTrend,
      activeNurses: activeNurses ?? this.activeNurses,
      activeNursesDesc: activeNursesDesc ?? this.activeNursesDesc,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      earningsDesc: earningsDesc ?? this.earningsDesc,
      upcomingBookings: upcomingBookings ?? this.upcomingBookings,
    );
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
  final String? id;
  final String? dateMonth;
  final String? dateDay;
  final String? patientName;
  final String? serviceType;
  final String? time;
  final String? status;

  const NursingBookingModel({
    this.id,
    this.dateMonth,
    this.dateDay,
    this.patientName,
    this.serviceType,
    this.time,
    this.status,
  });

  factory NursingBookingModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const NursingBookingModel();

    String month = json['dateMonth'] ?? json['month'] ?? '';
    String day = json['dateDay'] ?? json['day'] ?? '';

    // If full date is provided (e.g. 2026-05-02)
    final dateStr = json['date'] ?? json['booking_date'] ?? json['appointment_date'];
    if (dateStr is String && dateStr.isNotEmpty) {
      try {
        final parsed = DateTime.parse(dateStr);
        final months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
        month = months[parsed.month - 1];
        day = parsed.day.toString();
      } catch (_) {}
    }

    if (month.isEmpty) month = 'MAY';
    if (day.isEmpty) day = '1';

    return NursingBookingModel(
      id: json['id']?.toString() ?? json['booking_id']?.toString(),
      dateMonth: month,
      dateDay: day,
      patientName: json['patientName'] ?? json['patient_name'] ?? json['patient'] ?? 'Patient',
      serviceType: json['serviceType'] ??
          json['service_name'] ??
          json['service'] ??
          json['type'] ??
          'Nursing Care',
      time: json['time'] ?? json['booking_time'] ?? json['appointment_time'] ?? '09:00 AM',
      status: json['status']?.toString() ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateMonth': dateMonth,
      'dateDay': dateDay,
      'patientName': patientName,
      'serviceType': serviceType,
      'time': time,
      'status': status,
    };
  }

  NursingBookingModel copyWith({
    String? id,
    String? dateMonth,
    String? dateDay,
    String? patientName,
    String? serviceType,
    String? time,
    String? status,
  }) {
    return NursingBookingModel(
      id: id ?? this.id,
      dateMonth: dateMonth ?? this.dateMonth,
      dateDay: dateDay ?? this.dateDay,
      patientName: patientName ?? this.patientName,
      serviceType: serviceType ?? this.serviceType,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, dateMonth, dateDay, patientName, serviceType, time, status];
}
