import 'package:equatable/equatable.dart';
import '../../../../features/auth/data/models/user_type_model.dart';

enum BookingType { branchVisit, homeVisit }
enum BookingStatus { pending, confirmed, completed, rejected }
enum PaymentStatus { paid, pending }

class BookingModel extends Equatable {
  final String id;
  final BookingType type;
  final String patientName;
  final String patientPhone;
  final String serviceName;
  final String locationName;
  final String date;
  final String time;
  final BookingStatus status;
  final PaymentStatus paymentStatus;
  final double fee;

  const BookingModel({
    required this.id,
    required this.type,
    required this.patientName,
    required this.patientPhone,
    required this.serviceName,
    required this.locationName,
    required this.date,
    required this.time,
    required this.status,
    required this.paymentStatus,
    required this.fee,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      type: BookingType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => BookingType.branchVisit,
      ),
      patientName: json['patientName'] ?? '',
      patientPhone: json['patientPhone'] ?? '',
      serviceName: json['serviceName'] ?? '',
      locationName: json['locationName'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      status: BookingStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BookingStatus.pending,
      ),
      paymentStatus: PaymentStatus.values.firstWhere(
        (e) => e.name == json['paymentStatus'],
        orElse: () => PaymentStatus.pending,
      ),
      fee: (json['fee'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'patientName': patientName,
      'patientPhone': patientPhone,
      'serviceName': serviceName,
      'locationName': locationName,
      'date': date,
      'time': time,
      'status': status.name,
      'paymentStatus': paymentStatus.name,
      'fee': fee,
    };
  }
  
  BookingModel copyWith({
    String? id,
    BookingType? type,
    String? patientName,
    String? patientPhone,
    String? serviceName,
    String? locationName,
    String? date,
    String? time,
    BookingStatus? status,
    PaymentStatus? paymentStatus,
    double? fee,
  }) {
    return BookingModel(
      id: id ?? this.id,
      type: type ?? this.type,
      patientName: patientName ?? this.patientName,
      patientPhone: patientPhone ?? this.patientPhone,
      serviceName: serviceName ?? this.serviceName,
      locationName: locationName ?? this.locationName,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      fee: fee ?? this.fee,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        patientName,
        patientPhone,
        serviceName,
        locationName,
        date,
        time,
        status,
        paymentStatus,
        fee,
      ];
}

class MockBookingData {
  static List<BookingModel> generateMockBookings(UserType userType) {
    return [
      BookingModel(
        id: '1',
        type: BookingType.branchVisit,
        patientName: 'Mohamed Ali',
        patientPhone: '01012345678',
        serviceName: userType == UserType.radiologyCenter ? 'MRI Scan' : (userType == UserType.laboratory ? 'PCR' : 'Nursing Service'),
        locationName: 'New cairo',
        date: '2026-02-06',
        time: '10:00 AM',
        status: BookingStatus.pending,
        paymentStatus: PaymentStatus.paid,
        fee: 300,
      ),
      BookingModel(
        id: '2',
        type: BookingType.homeVisit,
        patientName: 'Heba Salem',
        patientPhone: '01187654321',
        serviceName: userType == UserType.radiologyCenter ? 'X-Ray' : (userType == UserType.laboratory ? 'Home Consultation' : 'Home Nursing'),
        locationName: '',
        date: '2026-02-07',
        time: '03:00 PM',
        status: BookingStatus.confirmed,
        paymentStatus: PaymentStatus.pending,
        fee: 500,
      ),
      BookingModel(
        id: '3',
        type: BookingType.homeVisit,
        patientName: 'Fatma Mahmoud',
        patientPhone: '01098765432',
        serviceName: userType == UserType.radiologyCenter ? 'X-Ray' : (userType == UserType.laboratory ? 'Heart Check-up' : 'Elderly Care'),
        locationName: '',
        date: '2026-02-05',
        time: '09:00 AM',
        status: BookingStatus.completed,
        paymentStatus: PaymentStatus.paid,
        fee: 300,
      ),
    ];
  }
}
