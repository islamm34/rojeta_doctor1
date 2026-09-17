import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/endpoints.dart';
import '../../../../features/auth/data/models/user_type_model.dart';
import '../models/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<List<BookingModel>> getBookings(
    UserType userType, {
    String? status,
    String? date,
    int? page,
    int? limit,
  });
  Future<void> updateBookingStatus(String bookingId, BookingStatus status);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final ApiConsumer apiConsumer;

  BookingRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<BookingModel>> getBookings(
    UserType userType, {
    String? status,
    String? date,
    int? page,
    int? limit,
  }) async {
    final queryParams = <String, dynamic>{};
    if (status != null && status.isNotEmpty) {
      queryParams['status'] = status;
    }
    if (date != null && date.isNotEmpty) {
      queryParams['date'] = date;
    }
    if (page != null) {
      queryParams['page'] = page;
    }
    if (limit != null) {
      queryParams['limit'] = limit;
    }
    if (userType == UserType.radiologyCenter) {
      queryParams['type'] = 'radiology';
    } else if (userType == UserType.laboratory) {
      queryParams['type'] = 'lab';
    }

    final response = await apiConsumer.get(
      Endpoints.bookings,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );

    List<dynamic> items = [];
    if (response is List) {
      items = response;
    } else if (response is Map<String, dynamic>) {
      final dataField = response['data'];
      if (dataField is List) {
        items = dataField;
      } else if (dataField is Map<String, dynamic>) {
        if (dataField['data'] is List) {
          items = dataField['data'] as List<dynamic>;
        } else if (dataField['bookings'] is List) {
          items = dataField['bookings'] as List<dynamic>;
        }
      } else if (response['bookings'] is List) {
        items = response['bookings'] as List<dynamic>;
      }
    }

    return items
        .whereType<Map<String, dynamic>>()
        .map((e) => BookingModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> updateBookingStatus(
    String bookingId,
    BookingStatus status,
  ) async {
    await apiConsumer.patch(
      Endpoints.bookingStatus(bookingId),
      data: {'status': status.name},
    );
  }
}
