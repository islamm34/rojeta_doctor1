import 'package:equatable/equatable.dart';
import 'lab_upcoming_booking_model.dart';
import 'lab_special_offer_model.dart';

class LabHomeModel extends Equatable {
  final int todayBookings;
  final String todayBookingsProgress;
  final int pendingRequests;
  final int homeVisits;
  final LabUpcomingBookingModel upcomingBooking;
  final LabSpecialOfferModel specialOffer;

  const LabHomeModel({
    required this.todayBookings,
    required this.todayBookingsProgress,
    required this.pendingRequests,
    required this.homeVisits,
    required this.upcomingBooking,
    required this.specialOffer,
  });

  factory LabHomeModel.fromJson(Map<String, dynamic> json) {
    return LabHomeModel(
      todayBookings: json['todayBookings'] ?? 0,
      todayBookingsProgress: json['todayBookingsProgress'] ?? '',
      pendingRequests: json['pendingRequests'] ?? 0,
      homeVisits: json['homeVisits'] ?? 0,
      upcomingBooking: LabUpcomingBookingModel.fromJson(json['upcomingBooking'] ?? {}),
      specialOffer: LabSpecialOfferModel.fromJson(json['specialOffer'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todayBookings': todayBookings,
      'todayBookingsProgress': todayBookingsProgress,
      'pendingRequests': pendingRequests,
      'homeVisits': homeVisits,
      'upcomingBooking': upcomingBooking.toJson(),
      'specialOffer': specialOffer.toJson(),
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
