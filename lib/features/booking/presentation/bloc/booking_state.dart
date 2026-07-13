import 'package:equatable/equatable.dart';
import '../../data/models/booking_model.dart';

enum BookingStateStatus { initial, loading, success, failure }

class BookingState extends Equatable {
  final BookingStateStatus status;
  final List<BookingModel> allBookings;
  final List<BookingModel> filteredBookings;
  final String? errorMessage;
  final String currentFilter; // 'All', 'Pending', 'Confirmed', 'Completed', 'Rejected'

  const BookingState({
    this.status = BookingStateStatus.initial,
    this.allBookings = const [],
    this.filteredBookings = const [],
    this.errorMessage,
    this.currentFilter = 'All',
  });

  BookingState copyWith({
    BookingStateStatus? status,
    List<BookingModel>? allBookings,
    List<BookingModel>? filteredBookings,
    String? errorMessage,
    String? currentFilter,
  }) {
    return BookingState(
      status: status ?? this.status,
      allBookings: allBookings ?? this.allBookings,
      filteredBookings: filteredBookings ?? this.filteredBookings,
      errorMessage: errorMessage, // Set to null if not explicitly provided, wait no, let's keep it null if not provided only if we want to clear it.
      // Wait, in generalrules.md it says: "populate it only when status resolves to .failure, and clear it explicitly back to null when shifting back to .loading."
      // Since copyWith needs to be able to clear it, we should do:
      // errorMessage: status == BookingStateStatus.failure ? (errorMessage ?? this.errorMessage) : null,
      // Or just pass null explicitly when needed. Let's use a special object or just `String? errorMessage` but if `status` is loading, we can clear it manually.
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }

  // Proper copyWith to allow clearing nullable fields
  BookingState copyWithClearError({
    BookingStateStatus? status,
    List<BookingModel>? allBookings,
    List<BookingModel>? filteredBookings,
    String? currentFilter,
  }) {
    return BookingState(
      status: status ?? this.status,
      allBookings: allBookings ?? this.allBookings,
      filteredBookings: filteredBookings ?? this.filteredBookings,
      errorMessage: null,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }

  BookingState copyWithError({
    required String errorMessage,
    BookingStateStatus? status,
    List<BookingModel>? allBookings,
    List<BookingModel>? filteredBookings,
    String? currentFilter,
  }) {
    return BookingState(
      status: status ?? BookingStateStatus.failure,
      allBookings: allBookings ?? this.allBookings,
      filteredBookings: filteredBookings ?? this.filteredBookings,
      errorMessage: errorMessage,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }
  
  @override
  List<Object?> get props => [status, allBookings, filteredBookings, errorMessage, currentFilter];
}
