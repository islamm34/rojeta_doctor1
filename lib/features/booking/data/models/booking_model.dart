import 'package:equatable/equatable.dart';

enum BookingType { branchVisit, homeVisit }

enum BookingStatus { pending, confirmed, completed, rejected, cancelled }

enum PaymentStatus { paid, pending, unpaid }

class BookingModel extends Equatable {
  final String? id;
  final String? bookingRefId;
  final BookingType? type;
  final String? patientName;
  final String? patientPhone;
  final String? serviceName;
  final String? locationName;
  final String? date;
  final String? time;
  final BookingStatus? status;
  final PaymentStatus? paymentStatus;
  final double? fee;
  final double? testPrice;
  final double? homeVisitFee;

  const BookingModel({
    this.id,
    this.bookingRefId,
    this.type,
    this.patientName,
    this.patientPhone,
    this.serviceName,
    this.locationName,
    this.date,
    this.time,
    this.status,
    this.paymentStatus,
    this.fee,
    this.testPrice,
    this.homeVisitFee,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final rawType = (json['type'] ?? json['visit_type'] ?? json['visitType'])
        ?.toString()
        .toLowerCase();
    BookingType? parsedType;
    if (rawType == 'homevisit' ||
        rawType == 'home_visit' ||
        rawType == 'home') {
      parsedType = BookingType.homeVisit;
    } else if (rawType != null) {
      parsedType = BookingType.branchVisit;
    }

    final rawStatus = (json['status'])?.toString().toLowerCase();
    BookingStatus? parsedStatus;
    if (rawStatus == 'confirmed') {
      parsedStatus = BookingStatus.confirmed;
    } else if (rawStatus == 'completed') {
      parsedStatus = BookingStatus.completed;
    } else if (rawStatus == 'rejected') {
      parsedStatus = BookingStatus.rejected;
    } else if (rawStatus == 'cancelled') {
      parsedStatus = BookingStatus.cancelled;
    } else if (rawStatus == 'pending') {
      parsedStatus = BookingStatus.pending;
    } else {
      parsedStatus = BookingStatus.pending;
    }

    final rawPayment =
        (json['paymentStatus'] ??
                json['payment_status'] ??
                json['payment_method_status'] ??
                json['payment']?['status'])
            ?.toString()
            .toLowerCase();
    PaymentStatus? parsedPayment;
    final isExplicitlyPaid =
        json['is_paid'] == true ||
        json['is_paid'] == 1 ||
        json['paid'] == true ||
        json['isPaid'] == true ||
        rawPayment == 'paid' ||
        rawPayment == 'completed' ||
        rawPayment == 'success';

    if (isExplicitlyPaid) {
      parsedPayment = PaymentStatus.paid;
    } else if (rawPayment == 'pending' || rawPayment == 'processing') {
      parsedPayment = PaymentStatus.pending;
    } else if (rawPayment == 'unpaid' || rawPayment == 'failed') {
      parsedPayment = PaymentStatus.unpaid;
    }

    final rawTestPrice =
        json['test_price'] ??
        json['price'] ??
        json['service_price'] ??
        json['scan_price'];
    final double? parsedTestPrice = (rawTestPrice is num)
        ? rawTestPrice.toDouble()
        : (rawTestPrice is String ? double.tryParse(rawTestPrice) : null);

    final rawHomeVisitFee =
        json['home_visit_fee'] ??
        json['homeVisitFee'] ??
        json['visit_fee'] ??
        json['delivery_fee'] ??
        json['collection_fee'] ??
        json['collectionFee'];
    final double? parsedHomeVisitFee = (rawHomeVisitFee is num)
        ? rawHomeVisitFee.toDouble()
        : (rawHomeVisitFee is String ? double.tryParse(rawHomeVisitFee) : null);

    final rawFee =
        json['totalPrice'] ??
        json['total_price'] ??
        json['fee'] ??
        json['service_fee'] ??
        json['total'] ??
        json['amount'];
    double? parsedFee;
    if (rawFee is num) {
      parsedFee = rawFee.toDouble();
    } else if (rawFee is String) {
      parsedFee = double.tryParse(rawFee);
    }

    if (parsedFee == null || parsedFee == 0) {
      if (parsedTestPrice != null || parsedHomeVisitFee != null) {
        parsedFee = ((parsedTestPrice ?? 0) + (parsedHomeVisitFee ?? 0))
            .toDouble();
      }
    }

    return BookingModel(
      id:
          json['id']?.toString() ??
          json['bookingRefId']?.toString() ??
          json['booking_ref_id']?.toString(),
      bookingRefId:
          json['bookingRefId']?.toString() ??
          json['booking_ref_id']?.toString() ??
          json['id']?.toString(),
      type: parsedType ?? BookingType.branchVisit,
      patientName:
          (json['patientName'] ??
                  json['patient_name'] ??
                  json['patient']?['name'])
              ?.toString(),
      patientPhone:
          (json['patientPhone'] ??
                  json['patient_phone'] ??
                  json['patient']?['phone'])
              ?.toString(),
      serviceName:
          (json['serviceName'] ??
                  json['service_name'] ??
                  json['title'] ??
                  json['test_name'] ??
                  json['scan_name'])
              ?.toString(),
      locationName:
          (json['locationName'] ??
                  json['location_name'] ??
                  json['address'] ??
                  json['patient_address'] ??
                  json['patient']?['address'] ??
                  json['area'] ??
                  json['branch']?['name'] ??
                  json['branch_name'])
              ?.toString(),
      date: (json['date'] ?? json['booking_date'])?.toString(),
      time: (json['time'] ?? json['booking_time'])?.toString(),
      status: parsedStatus,
      paymentStatus: parsedPayment ?? PaymentStatus.pending,
      fee: parsedFee,
      testPrice: parsedTestPrice,
      homeVisitFee: parsedHomeVisitFee,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingRefId': bookingRefId,
      'type': type?.name,
      'patientName': patientName,
      'patientPhone': patientPhone,
      'serviceName': serviceName,
      'locationName': locationName,
      'date': date,
      'time': time,
      'status': status?.name,
      'paymentStatus': paymentStatus?.name,
      'totalPrice': fee,
      'test_price': testPrice,
      'home_visit_fee': homeVisitFee,
    };
  }

  BookingModel copyWith({
    String? id,
    String? bookingRefId,
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
    double? testPrice,
    double? homeVisitFee,
  }) {
    return BookingModel(
      id: id ?? this.id,
      bookingRefId: bookingRefId ?? this.bookingRefId,
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
      testPrice: testPrice ?? this.testPrice,
      homeVisitFee: homeVisitFee ?? this.homeVisitFee,
    );
  }

  @override
  List<Object?> get props => [
    id,
    bookingRefId,
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
    testPrice,
    homeVisitFee,
  ];
}
