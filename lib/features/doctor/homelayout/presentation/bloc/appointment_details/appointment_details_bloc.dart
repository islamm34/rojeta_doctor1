import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/error/exceptions.dart';

import '../../../data/repositories/doctor_appointments_repository.dart';
import 'appointment_details_event.dart';
import 'appointment_details_state.dart';

class AppointmentDetailsBloc
    extends Bloc<AppointmentDetailsEvent, AppointmentDetailsState> {
  final DoctorAppointmentsRepository repository;

  AppointmentDetailsBloc({required this.repository})
    : super(const AppointmentDetailsState()) {
    on<FetchAppointmentDetailsEvent>(_onFetchDetails);
    on<ConfirmCashPaymentEvent>(_onConfirmCashPayment);
  }

  Future<void> _onFetchDetails(
    FetchAppointmentDetailsEvent event,
    Emitter<AppointmentDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AppointmentDetailsStatus.loading,
        errorMessage: null,
      ),
    );
    try {
      final details = await repository.getAppointmentDetails(
        event.appointmentId,
      );
      emit(
        state.copyWith(
          status: AppointmentDetailsStatus.success,
          appointmentDetails: details,
        ),
      );
    } catch (e) {
      final message = e is ServerException
          ? e.message
          : (e is NetworkException ? e.message : e.toString());
      emit(
        state.copyWith(
          status: AppointmentDetailsStatus.failure,
          errorMessage: message,
        ),
      );
    }
  }

  Future<void> _onConfirmCashPayment(
    ConfirmCashPaymentEvent event,
    Emitter<AppointmentDetailsState> emit,
  ) async {
    try {
      await repository.confirmCashPayment(
        appointmentId: event.appointmentId,
        amountPaid: event.amountPaid,
      );
      if (state.appointmentDetails != null) {
        final current = state.appointmentDetails!;
        final updated = current.copyWith(
          paymentStatus: 'paid',
          paymentMethod: 'cash',
        );
        emit(state.copyWith(
          status: AppointmentDetailsStatus.success,
          appointmentDetails: updated,
        ));
      }
    } catch (e) {
      final message = e is ServerException
          ? e.message
          : (e is NetworkException ? e.message : e.toString());
      emit(
        state.copyWith(
          status: AppointmentDetailsStatus.failure,
          errorMessage: message,
        ),
      );
    }
  }
}
