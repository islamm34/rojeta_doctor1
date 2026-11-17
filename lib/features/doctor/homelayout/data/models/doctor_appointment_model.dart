import 'package:equatable/equatable.dart';
import '../../../../../../core/local/user_hive_helper.dart';

class DoctorAppointmentModel extends Equatable {
  final String id;
  final String? patientId;
  final String patientName;
  final String patientAge;
  final String patientGender;
  final String appointmentTime;
  final String appointmentDate;
  final String type;
  final String status;
  final String? patientPhone;
  final bool isUrgent;
  final String? location;
  final String? notes;
  final String? feeOriginal;
  final String? feeCurrent;
  final String? discount;
  final String? paymentMethod;
  final bool isOnline;

  const DoctorAppointmentModel({
    required this.id,
    this.patientId,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.appointmentTime,
    required this.appointmentDate,
    required this.type,
    required this.status,
    this.patientPhone,
    this.isUrgent = false,
    this.location,
    this.notes,
    this.feeOriginal,
    this.feeCurrent,
    this.discount,
    this.paymentMethod,
    this.isOnline = false,
  });

  static String normalizeStatus(dynamic rawStatus) {
    if (rawStatus == null) return 'Pending';
    final s = rawStatus.toString().trim().toLowerCase();
    if (s.isEmpty) return 'Pending';

    if (s == 'pending' ||
        s == 'قيد الانتظار' ||
        s == 'معلق' ||
        s == 'waiting' ||
        s == 'new' ||
        s == 'requested' ||
        s == 'unconfirmed' ||
        s == 'under_review' ||
        s == '1') {
      return 'Pending';
    }

    if (s == 'confirmed' ||
        s == 'مؤكد' ||
        s == 'accepted' ||
        s == 'مقبول' ||
        s == 'approved' ||
        s == 'active' ||
        s == 'scheduled' ||
        s == '2') {
      return 'Confirmed';
    }

    if (s == 'completed' ||
        s == 'مكتمل' ||
        s == 'finished' ||
        s == 'منتهي' ||
        s == 'done' ||
        s == 'closed' ||
        s == '3') {
      return 'Completed';
    }

    if (s == 'cancelled' ||
        s == 'canceled' ||
        s == 'ملغي' ||
        s == 'ملغى' ||
        s == 'rejected' ||
        s == 'مرفوض' ||
        s == 'declined' ||
        s == '4') {
      return 'Cancelled';
    }

    return s[0].toUpperCase() + s.substring(1);
  }

  static String formatLocation(dynamic rawLoc) {
    if (rawLoc == null) return '';
    if (rawLoc is Map) {
      final street = rawLoc['street']?.toString().trim();
      final area = rawLoc['area']?.toString().trim();
      final city = rawLoc['city']?.toString().trim();
      final parts = <String>[];
      if (street != null && street.isNotEmpty) parts.add(street);
      if (area != null && area.isNotEmpty && !parts.contains(area)) parts.add(area);
      if (city != null && city.isNotEmpty && !parts.contains(city)) {
        parts.add(city);
      }
      return parts.join('، ');
    }
    final str = rawLoc.toString().trim();
    if (str.startsWith('{') && str.endsWith('}')) {
      final streetMatch = RegExp(
        r'street:\s*(.*?)(?=,\s*(?:area|city):|\s*})',
        caseSensitive: false,
      ).firstMatch(str);
      final areaMatch = RegExp(
        r'area:\s*(.*?)(?=,\s*(?:street|city):|\s*})',
        caseSensitive: false,
      ).firstMatch(str);
      final cityMatch = RegExp(
        r'city:\s*(.*?)(?=,\s*(?:street|area):|\s*})',
        caseSensitive: false,
      ).firstMatch(str);

      final street = streetMatch?.group(1)?.trim();
      final area = areaMatch?.group(1)?.trim();
      final city = cityMatch?.group(1)?.trim();
      final parts = <String>[];
      if (street != null && street.isNotEmpty && street != 'null') parts.add(street);
      if (area != null && area.isNotEmpty && area != 'null' && !parts.contains(area)) {
        parts.add(area);
      }
      if (city != null && city.isNotEmpty && city != 'null' && !parts.contains(city)) {
        parts.add(city);
      }
      if (parts.isNotEmpty) return parts.join('، ');

      // Fallback: strip curly braces and keys
      final cleaned = str
          .replaceAll(RegExp(r'[{}]'), '')
          .replaceAll(RegExp(r'\b(area|city|street):\s*'), '')
          .trim();
      return cleaned;
    }
    return str;
  }

  factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json) {
    // Nested patient object if returned by backend
    final patientObj = json['patient'] is Map<String, dynamic>
        ? json['patient'] as Map<String, dynamic>
        : (json['user'] is Map<String, dynamic>
              ? json['user'] as Map<String, dynamic>
              : null);

    final patientName =
        (json['patientName'] ??
                json['patient_name'] ??
                patientObj?['name'] ??
                patientObj?['full_name'] ??
                json['name'] ??
                '')
            .toString();

    final patientAge =
        (json['patientAge'] ?? json['patient_age'] ?? patientObj?['age'] ?? '')
            .toString();

    final patientGender =
        (json['patientGender'] ??
                json['patient_gender'] ??
                patientObj?['gender'] ??
                '')
            .toString();

    final patientPhone =
        (json['patientPhone'] ??
                json['patient_phone'] ??
                patientObj?['phone'] ??
                json['phone'])
            ?.toString();

    final patientId =
        (json['patientId'] ??
                json['patient_id'] ??
                patientObj?['id'] ??
                json['user_id'])
            ?.toString();

    final appointmentTime =
        (json['appointmentTime'] ??
                json['appointment_time'] ??
                json['time'] ??
                json['booking_time'] ??
                '')
            .toString();

    final appointmentDate =
        (json['appointmentDate'] ??
                json['appointment_date'] ??
                json['date'] ??
                json['booking_date'] ??
                '')
            .toString();

    final type =
        (json['type'] ??
                json['service_type'] ??
                json['consultation_type'] ??
                '')
            .toString();

    final rawStatus =
        json['status'] ??
        json['booking_status'] ??
        json['appointment_status'] ??
        json['state'];
    final status = normalizeStatus(rawStatus);

    final isUrgent =
        json['isUrgent'] == true ||
        json['is_urgent'] == true ||
        json['urgent'] == true ||
        json['is_urgent'] == 1;

    final visitTypeStr = (json['visit_type'] ?? json['visitType'] ?? type)
        .toString()
        .toLowerCase();
    final isHomeVisit = visitTypeStr.contains('home');

    // Extract clinic information
    final clinicObj = json['clinic'] is Map<String, dynamic>
        ? json['clinic'] as Map<String, dynamic>
        : (json['doctor'] is Map<String, dynamic> &&
                  json['doctor']['clinic'] is Map<String, dynamic>
              ? json['doctor']['clinic'] as Map<String, dynamic>
              : null);

    final clinicAddress =
        (json['clinic_address'] ??
                json['clinicAddress'] ??
                clinicObj?['address'] ??
                clinicObj?['location'] ??
                clinicObj?['full_address'] ??
                clinicObj?['fullAddress'] ??
                json['clinic_location'] ??
                json['clinicLocation'])
            ?.toString();

    final clinicName =
        (json['clinic_name'] ??
                json['clinicName'] ??
                clinicObj?['name'] ??
                clinicObj?['title'] ??
                json['facility_name'])
            ?.toString();

    final patientAddress =
        (patientObj?['address'] ??
                patientObj?['location'] ??
                json['patient_address'] ??
                json['patientAddress'])
            ?.toString();

    String? location;
    if (isHomeVisit) {
      // Home visits take the patient's home address
      location =
          patientAddress ??
          (json['address']?.toString()) ??
          (json['location']?.toString());
    } else {
      // Clinic visits MUST display the clinic location, not the patient address!
      if (clinicAddress != null && clinicAddress.trim().isNotEmpty) {
        if (clinicName != null &&
            clinicName.trim().isNotEmpty &&
            !clinicAddress.contains(clinicName)) {
          location = '${clinicName.trim()}، ${clinicAddress.trim()}';
        } else {
          location = clinicAddress.trim();
        }
      } else if (clinicName != null && clinicName.trim().isNotEmpty) {
        location = clinicName.trim();
      } else if (json['clinic_address'] != null) {
        location = json['clinic_address'].toString().trim();
      } else {
        // Check if there is a cached doctor clinic address stored in UserHiveHelper
        final cachedClinic = UserHiveHelper.getDoctorClinicAddress();
        if (cachedClinic != null && cachedClinic.trim().isNotEmpty) {
          location = cachedClinic.trim();
        } else {
          final generalLoc = (json['location'] ?? json['address'])?.toString();
          if (generalLoc != null &&
              generalLoc != patientAddress &&
              generalLoc.trim().isNotEmpty) {
            location = generalLoc.trim();
          }
        }
      }
    }

    final notes =
        (json['notes'] ??
                json['symptoms'] ??
                json['complaint'] ??
                json['reason'] ??
                json['description'])
            ?.toString();

    final feeOriginal =
        (json['feeOriginal'] ??
                json['fee_original'] ??
                json['original_fee'] ??
                json['fee'] ??
                json['price'] ??
                json['amount'])
            ?.toString();

    final feeCurrent =
        (json['feeCurrent'] ??
                json['fee_current'] ??
                json['current_fee'] ??
                json['total'] ??
                json['total_price'] ??
                json['fee'] ??
                json['price'])
            ?.toString();

    final discount =
        (json['discount'] ?? json['discount_amount'] ?? json['discount_price'])
            ?.toString();

    final paymentMethod =
        (json['paymentMethod'] ??
                json['payment_method'] ??
                json['payment_type'])
            ?.toString();

    final isOnline =
        json['isOnline'] == true ||
        json['is_online'] == true ||
        type.toLowerCase().contains('online') ||
        type.toLowerCase().contains('video');

    return DoctorAppointmentModel(
      id: json['id']?.toString() ?? json['booking_id']?.toString() ?? '',
      patientId: patientId,
      patientName: patientName,
      patientAge: patientAge,
      patientGender: patientGender,
      appointmentTime: appointmentTime,
      appointmentDate: appointmentDate,
      type: type,
      status: status,
      patientPhone: patientPhone,
      isUrgent: isUrgent,
      location: formatLocation(location),
      notes: notes,
      feeOriginal: feeOriginal,
      feeCurrent: feeCurrent,
      discount: discount,
      paymentMethod: paymentMethod,
      isOnline: isOnline,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'patientName': patientName,
      'patientAge': patientAge,
      'patientGender': patientGender,
      'appointmentTime': appointmentTime,
      'appointmentDate': appointmentDate,
      'type': type,
      'status': status,
      'patientPhone': patientPhone,
      'isUrgent': isUrgent,
      'location': location,
      'notes': notes,
      'feeOriginal': feeOriginal,
      'feeCurrent': feeCurrent,
      'discount': discount,
      'paymentMethod': paymentMethod,
      'isOnline': isOnline,
    };
  }

  DoctorAppointmentModel copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? patientAge,
    String? patientGender,
    String? appointmentTime,
    String? appointmentDate,
    String? type,
    String? status,
    String? patientPhone,
    bool? isUrgent,
    String? location,
    String? notes,
    String? feeOriginal,
    String? feeCurrent,
    String? discount,
    String? paymentMethod,
    bool? isOnline,
  }) {
    return DoctorAppointmentModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      patientAge: patientAge ?? this.patientAge,
      patientGender: patientGender ?? this.patientGender,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      type: type ?? this.type,
      status: status ?? this.status,
      patientPhone: patientPhone ?? this.patientPhone,
      isUrgent: isUrgent ?? this.isUrgent,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      feeOriginal: feeOriginal ?? this.feeOriginal,
      feeCurrent: feeCurrent ?? this.feeCurrent,
      discount: discount ?? this.discount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  List<Object?> get props => [
    id,
    patientId,
    patientName,
    patientAge,
    patientGender,
    appointmentTime,
    appointmentDate,
    type,
    status,
    patientPhone,
    isUrgent,
    location,
    notes,
    feeOriginal,
    feeCurrent,
    discount,
    paymentMethod,
    isOnline,
  ];
}
