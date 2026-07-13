import 'package:dartz/dartz.dart';
import 'package:rojeta_doctor/core/error/failures.dart';
import '../../data/models/booking_model.dart';
import '../repositories/booking_repository.dart';
import '../../../../features/auth/data/models/user_type_model.dart';

class GetBookingsUseCase {
  final BookingRepository repository;

  GetBookingsUseCase({required this.repository});

  Future<Either<Failure, List<BookingModel>>> call(UserType userType) {
    return repository.getBookings(userType);
  }
}
