import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rojeta_doctor/core/error/failures.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_datasource.dart';
import '../models/booking_model.dart';
import '../../../../features/auth/data/models/user_type_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<BookingModel>>> getBookings(UserType userType) async {
    try {
      final bookings = await remoteDataSource.getBookings(userType);
      return Right(bookings);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure(e.message ?? 'Server error occurred'));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateBookingStatus(String bookingId, BookingStatus status) async {
    try {
      await remoteDataSource.updateBookingStatus(bookingId, status);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure(e.message ?? 'Server error occurred'));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> confirmPayment(String bookingId) async {
    try {
      await remoteDataSource.confirmPayment(bookingId);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure(e.message ?? 'Server error occurred'));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
