import 'package:equatable/equatable.dart';

abstract class AppointmentDetailsEvent extends Equatable {
  const AppointmentDetailsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAppointmentDetailsEvent extends AppointmentDetailsEvent {
  final String appointmentId;

  const FetchAppointmentDetailsEvent(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}

class ConfirmCashPaymentEvent extends AppointmentDetailsEvent {
  final String appointmentId;
  final double? amountPaid;

  const ConfirmCashPaymentEvent({
    required this.appointmentId,
    this.amountPaid,
  });

  @override
  List<Object?> get props => [appointmentId, amountPaid];
}
