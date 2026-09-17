import 'package:equatable/equatable.dart';

import 'lab_special_offer_model.dart';
import 'lab_upcoming_booking_model.dart';

class LabHomeModel extends Equatable {
  final int? todayBookings;
  final String? todayBookingsProgress;
  final int? pendingRequests;
  final int? homeVisits;
  final LabUpcomingBookingModel? upcomingBooking;
  final LabSpecialOfferModel? specialOffer;

  const LabHomeModel({
    this.todayBookings,
    this.todayBookingsProgress,
    this.pendingRequests,
    this.homeVisits,
    this.upcomingBooking,
    this.specialOffer,
  });

  factory LabHomeModel.fromJson(Map<String, dynamic> json) {
    return LabHomeModel(
      todayBookings:
          (json['todayBookings'] ??
                  json['today_bookings'] ??
                  json['total_bookings_today'])
              as int?,
      todayBookingsProgress:
          (json['todayBookingsProgress'] ??
                  json['today_bookings_progress'] ??
                  json['progress'])
              as String?,
      pendingRequests:
          (json['pendingRequests'] ?? json['pending_requests']) as int?,
      homeVisits:
          (json['homeVisits'] ??
                  json['home_visits'] ??
                  json['total_home_visits'])
              as int?,
      upcomingBooking:
          json['upcomingBooking'] != null &&
              json['upcomingBooking'] is Map<String, dynamic>
          ? LabUpcomingBookingModel.fromJson(
              json['upcomingBooking'] as Map<String, dynamic>,
            )
          : (json['upcoming_booking'] != null &&
                    json['upcoming_booking'] is Map<String, dynamic>
                ? LabUpcomingBookingModel.fromJson(
                    json['upcoming_booking'] as Map<String, dynamic>,
                  )
                : null),
      specialOffer:
          json['specialOffer'] != null &&
              json['specialOffer'] is Map<String, dynamic>
          ? LabSpecialOfferModel.fromJson(
              json['specialOffer'] as Map<String, dynamic>,
            )
          : (json['special_offer'] != null &&
                    json['special_offer'] is Map<String, dynamic>
                ? LabSpecialOfferModel.fromJson(
                    json['special_offer'] as Map<String, dynamic>,
                  )
                : null),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todayBookings': todayBookings,
      'todayBookingsProgress': todayBookingsProgress,
      'pendingRequests': pendingRequests,
      'homeVisits': homeVisits,
      'upcomingBooking': upcomingBooking?.toJson(),
      'specialOffer': specialOffer?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    todayBookings,
    todayBookingsProgress,
    pendingRequests,
    homeVisits,
    upcomingBooking,
    specialOffer,
  ];
}
