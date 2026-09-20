import 'package:dartz/dartz.dart';
import 'package:rojeta_doctor/core/error/failures.dart';
import '../../data/models/booking_model.dart';

import '../../../../features/auth/data/models/user_type_model.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<BookingModel>>> getBookings(UserType userType);
  Future<Either<Failure, void>> updateBookingStatus(String bookingId, BookingStatus status);
  Future<Either<Failure, void>> confirmPayment(String bookingId);
}
