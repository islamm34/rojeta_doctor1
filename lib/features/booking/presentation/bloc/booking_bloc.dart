import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/booking_model.dart';
import '../../domain/repositories/booking_repository.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository repository;

  BookingBloc({required this.repository}) : super(const BookingState()) {
    on<FetchBookingsEvent>(_onFetchBookings);
    on<ChangeFilterEvent>(_onChangeFilter);
    on<AcceptBookingEvent>(_onAcceptBooking);
    on<RejectBookingEvent>(_onRejectBooking);
    on<ConfirmBookingPaymentEvent>(_onConfirmBookingPayment);
  }

  Future<void> _onFetchBookings(
    FetchBookingsEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWithClearError(status: BookingStateStatus.loading));

    final result = await repository.getBookings(event.userType);

    result.fold(
      (failure) => emit(state.copyWithError(errorMessage: failure.message)),
      (bookings) {
        emit(
          state.copyWithClearError(
            status: BookingStateStatus.success,
            allBookings: bookings,
            filteredBookings: _filterBookings(bookings, state.currentFilter),
          ),
        );
      },
    );
  }

  void _onChangeFilter(ChangeFilterEvent event, Emitter<BookingState> emit) {
    if (event.newFilter == state.currentFilter) return;

    emit(
      state.copyWithClearError(
        currentFilter: event.newFilter,
        filteredBookings: _filterBookings(state.allBookings, event.newFilter),
      ),
    );
  }

  List<BookingModel> _filterBookings(
    List<BookingModel> bookings,
    String filter,
  ) {
    if (filter == 'All' || filter == 'الكل') return bookings;

    BookingStatus? targetStatus;
    if (filter == 'Pending' || filter == 'قيد الانتظار') {
      targetStatus = BookingStatus.pending;
    } else if (filter == 'Confirmed' || filter == 'مؤكد') {
      targetStatus = BookingStatus.confirmed;
    } else if (filter == 'Completed' || filter == 'مكتمل') {
      targetStatus = BookingStatus.completed;
    } else if (filter == 'Rejected' || filter == 'مرفوض') {
      targetStatus = BookingStatus.rejected;
    } else if (filter == 'Cancelled' || filter == 'ملغي') {
      targetStatus = BookingStatus.cancelled;
    }

    if (targetStatus == null) return bookings;
    return bookings.where((b) => b.status == targetStatus).toList();
  }

  Future<void> _onAcceptBooking(
    AcceptBookingEvent event,
    Emitter<BookingState> emit,
  ) async {
    final updatedAll = state.allBookings.map((b) {
      if (b.id == event.bookingId) {
        return b.copyWith(status: BookingStatus.confirmed);
      }
      return b;
    }).toList();

    emit(
      state.copyWithClearError(
        allBookings: updatedAll,
        filteredBookings: _filterBookings(updatedAll, state.currentFilter),
      ),
    );

    final result = await repository.updateBookingStatus(
      event.bookingId,
      BookingStatus.confirmed,
    );
    result.fold(
      (failure) => emit(state.copyWithError(errorMessage: failure.message)),
      (_) {}, // already updated optimistically
    );
  }

  Future<void> _onRejectBooking(
    RejectBookingEvent event,
    Emitter<BookingState> emit,
  ) async {
    final updatedAll = state.allBookings.map((b) {
      if (b.id == event.bookingId) {
        return b.copyWith(status: BookingStatus.rejected);
      }
      return b;
    }).toList();

    emit(
      state.copyWithClearError(
        allBookings: updatedAll,
        filteredBookings: _filterBookings(updatedAll, state.currentFilter),
      ),
    );

    final result = await repository.updateBookingStatus(
      event.bookingId,
      BookingStatus.rejected,
    );
    result.fold(
      (failure) => emit(state.copyWithError(errorMessage: failure.message)),
      (_) {},
    );
  }

  Future<void> _onConfirmBookingPayment(
    ConfirmBookingPaymentEvent event,
    Emitter<BookingState> emit,
  ) async {
    final updatedAll = state.allBookings.map((b) {
      if (b.id == event.bookingId) {
        return b.copyWith(paymentStatus: PaymentStatus.paid);
      }
      return b;
    }).toList();

    emit(
      state.copyWithClearError(
        allBookings: updatedAll,
        filteredBookings: _filterBookings(updatedAll, state.currentFilter),
      ),
    );

    final result = await repository.confirmPayment(event.bookingId);
    result.fold(
      (failure) => emit(state.copyWithError(errorMessage: failure.message)),
      (_) {}, // already updated optimistically
    );
  }
}
