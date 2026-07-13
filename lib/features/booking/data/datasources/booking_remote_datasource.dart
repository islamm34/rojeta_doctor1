import 'package:dio/dio.dart';
import '../models/booking_model.dart';

import '../../../../features/auth/data/models/user_type_model.dart';

abstract class BookingRemoteDataSource {
  Future<List<BookingModel>> getBookings(UserType userType);
  Future<void> updateBookingStatus(String bookingId, BookingStatus status);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final Dio dio;

  BookingRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<BookingModel>> getBookings(UserType userType) async {
    // In a real app:
    // final response = await dio.get(Endpoints.getBookings, queryParameters: {'isRadiology': isRadiology});
    // return (response.data as List).map((e) => BookingModel.fromJson(e)).toList();
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return MockBookingData.generateMockBookings(userType);
  }

  @override
  Future<void> updateBookingStatus(String bookingId, BookingStatus status) async {
    // In a real app:
    // await dio.post(Endpoints.updateBookingStatus, data: {'id': bookingId, 'status': status.name});
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
