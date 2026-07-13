import 'package:equatable/equatable.dart';
import '../../../../features/auth/data/models/user_type_model.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class FetchBookingsEvent extends BookingEvent {
  final UserType userType;

  const FetchBookingsEvent({required this.userType});

  @override
  List<Object> get props => [userType];
}

class ChangeFilterEvent extends BookingEvent {
  final String newFilter;

  const ChangeFilterEvent({required this.newFilter});

  @override
  List<Object> get props => [newFilter];
}

class AcceptBookingEvent extends BookingEvent {
  final String bookingId;

  const AcceptBookingEvent({required this.bookingId});

  @override
  List<Object> get props => [bookingId];
}

class RejectBookingEvent extends BookingEvent {
  final String bookingId;

  const RejectBookingEvent({required this.bookingId});

  @override
  List<Object> get props => [bookingId];
}
