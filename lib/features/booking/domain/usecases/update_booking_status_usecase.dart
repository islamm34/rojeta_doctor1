import 'package:dartz/dartz.dart';
import 'package:rojeta_doctor/core/error/failures.dart';
import '../../data/models/booking_model.dart';
import '../repositories/booking_repository.dart';

class UpdateBookingStatusUseCase {
  final BookingRepository repository;

  UpdateBookingStatusUseCase({required this.repository});

  Future<Either<Failure, void>> call(String bookingId, BookingStatus status) {
    return repository.updateBookingStatus(bookingId, status);
  }
}
