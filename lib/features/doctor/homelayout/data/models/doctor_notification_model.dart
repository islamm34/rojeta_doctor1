class DoctorNotificationModel {
  final String id;
  final String title;
  final String body;
  final String time;
  final bool isRead;
  final String priority; // 'High', 'Medium', 'Low'
  final String type; // 'appointment', 'payment', 'review', 'message', 'system', 'reminder', 'feature', 'new_appointment'
  final Map<String, dynamic>? data;
  final String? timeAgo;
  final bool isPinned;

  const DoctorNotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
    this.priority = 'Low',
    this.type = 'system',
    this.data,
    this.timeAgo,
    this.isPinned = false,
  });

  String? get patientName => (data?['patient_name'] ??
          data?['patientName'] ??
          data?['patient']?['name'] ??
          data?['name'])
      ?.toString();

  String? get patientPhone => (data?['patient_phone'] ??
          data?['patientPhone'] ??
          data?['phone'] ??
          data?['contact_phone'] ??
          data?['patient']?['phone'])
      ?.toString();

  String? get bookingRef => (data?['booking_ref'] ??
          data?['bookingRef'] ??
          data?['booking_id'] ??
          data?['bookingId'] ??
          data?['appointment_id'])
      ?.toString();

  String? get bookingDate => (data?['booking_date'] ??
          data?['bookingDate'] ??
          data?['date'] ??
          data?['appointment_date'])
      ?.toString();

  String? get bookingTime => (data?['booking_time'] ??
          data?['bookingTime'] ??
          data?['time'] ??
          data?['appointment_time'])
      ?.toString();

  String? get visitType =>
      (data?['visit_type'] ?? data?['visitType'] ?? data?['service_type'])
          ?.toString();

  String? get notes => (data?['notes'] ??
          data?['reason'] ??
          data?['complaint'] ??
          data?['patient_notes'] ??
          data?['patientNotes'] ??
          data?['symptoms'])
      ?.toString();

  String? get location => (data?['location'] ??
          data?['clinic_address'] ??
          data?['clinic_name'] ??
          data?['clinicAddress'] ??
          data?['address'])
      ?.toString();

  String? get fee => (data?['fee'] ??
          data?['price'] ??
          data?['fee_current'] ??
          data?['feeCurrent'] ??
          data?['total_amount'] ??
          data?['totalAmount'] ??
          data?['consultation_fee'])
      ?.toString();

  String? get paymentMethod => (data?['payment_method'] ??
          data?['paymentMethod'] ??
          data?['payment_type'] ??
          data?['payment'])
      ?.toString();

  String? get route => data?['route']?.toString();

  String? get appointmentId => (data?['appointment_id'] ??
          data?['appointmentId'] ??
          data?['booking_id'] ??
          data?['bookingId'] ??
          data?['id'])
      ?.toString();

  factory DoctorNotificationModel.fromJson(Map<String, dynamic> json) {
    final isReadVal = json['isRead'] ??
        json['is_read'] ??
        (json['read_at'] != null) ??
        (json['status'] == 'read');

    Map<String, dynamic>? dataMap;
    if (json['data'] is Map<String, dynamic>) {
      dataMap = json['data'] as Map<String, dynamic>;
    } else if (json['payload'] is Map<String, dynamic>) {
      dataMap = json['payload'] as Map<String, dynamic>;
    }

    final isPinnedVal = json['is_pinned'] ?? json['isPinned'];

    final rawTitle = (json['title'] ??
            json['header'] ??
            json['subject'] ??
            json['type'] ??
            'Notification')
        .toString();

    final rawBody = (json['body'] ??
            json['message'] ??
            json['content'] ??
            json['text'] ??
            json['description'] ??
            '')
        .toString();

    final pName = (dataMap?['patient_name'] ??
            dataMap?['patientName'] ??
            dataMap?['patient']?['name'] ??
            dataMap?['name'])
        ?.toString()
        .trim();

    final typeLower =
        (json['type'] ?? dataMap?['type'] ?? '').toString().toLowerCase();
    final isPayment = typeLower == 'payment' ||
        typeLower == 'payment_received' ||
        typeLower == 'payment_success' ||
        typeLower == 'cash_payment_confirmed' ||
        (dataMap != null && dataMap.containsKey('amount_paid')) ||
        rawTitle.toLowerCase().contains('payment') ||
        rawTitle.contains('دفع') ||
        rawBody.contains('تم دفع');

    final isBooking = !isPayment &&
        ((dataMap != null &&
                (dataMap.containsKey('booking_id') ||
                    dataMap.containsKey('appointment_id') ||
                    dataMap['type'] == 'booking' ||
                    dataMap['type'] == 'new_booking' ||
                    dataMap['type'] == 'appointment' ||
                    dataMap['type'] == 'new_appointment')) ||
            (json['type'] == 'appointment' ||
                json['type'] == 'new_appointment' ||
                json['type'] == 'booking') ||
            (pName != null && pName.isNotEmpty));

    // Enrich title with patient name if available
    String resolvedTitle = rawTitle;
    String resolvedBody = rawBody;

    if (isPayment) {
      if (pName != null && pName.isNotEmpty) {
        resolvedTitle = '💰 استلام دفعة مالية من $pName';
      } else if (rawTitle.isEmpty || rawTitle == 'Notification') {
        resolvedTitle = '💰 استلام دفعة مالية جديدة';
      }

      final fee = (dataMap?['amount_paid'] ??
              dataMap?['fee'] ??
              dataMap?['total_amount'] ??
              dataMap?['price'])
          ?.toString();
      final payment = (dataMap?['payment_method'] ??
              dataMap?['paymentMethod'] ??
              dataMap?['payment'])
          ?.toString();

      final lines = <String>[];
      if (pName != null && pName.isNotEmpty && !resolvedBody.contains(pName)) {
        lines.add('المريض: $pName');
      }
      if (fee != null && fee.isNotEmpty && !resolvedBody.contains(fee)) {
        lines.add('المبلغ: $fee ج.م');
      }
      if (payment != null && payment.isNotEmpty && !resolvedBody.contains(payment)) {
        lines.add('الدفع: $payment');
      }
      if (lines.isNotEmpty) {
        resolvedBody = lines.join(' • ');
      }
    } else if (pName != null && pName.isNotEmpty) {
      if (rawTitle.isEmpty ||
          rawTitle == 'Notification' ||
          rawTitle == 'إشعار جديد' ||
          rawTitle == 'طلب حجز جديد' ||
          rawTitle == 'New Appointment') {
        resolvedTitle = 'طلب حجز جديد من $pName';
      } else if (!rawTitle.contains(pName)) {
        resolvedTitle = '$rawTitle - $pName';
      }
    }
    if (isBooking && dataMap != null) {
      final date = (dataMap['booking_date'] ??
              dataMap['date'] ??
              dataMap['appointment_date'])
          ?.toString();
      final time = (dataMap['booking_time'] ??
              dataMap['time'] ??
              dataMap['appointment_time'])
          ?.toString();
      final notes = (dataMap['notes'] ??
              dataMap['reason'] ??
              dataMap['complaint'] ??
              dataMap['patient_notes'] ??
              dataMap['symptoms'])
          ?.toString();
      final location = (dataMap['location'] ??
              dataMap['clinic_name'] ??
              dataMap['clinic_address'] ??
              dataMap['address'])
          ?.toString();
      final fee = (dataMap['fee'] ??
              dataMap['price'] ??
              dataMap['total_amount'] ??
              dataMap['consultation_fee'])
          ?.toString();
      final payment = (dataMap['payment_method'] ??
              dataMap['paymentMethod'] ??
              dataMap['payment'])
          ?.toString();

      final lines = <String>[];
      if (pName != null && pName.isNotEmpty && !resolvedBody.contains(pName)) {
        lines.add('المريض: $pName');
      }
      if ((date != null && date.isNotEmpty) ||
          (time != null && time.isNotEmpty)) {
        final dt = [
          if (date != null && date.isNotEmpty) date,
          if (time != null && time.isNotEmpty) time,
        ].join(' - ');
        if (!resolvedBody.contains(dt)) lines.add('الموعد: $dt');
      }
      if (location != null &&
          location.isNotEmpty &&
          !resolvedBody.contains(location)) {
        lines.add('الموقع: $location');
      }
      if (notes != null &&
          notes.isNotEmpty &&
          !resolvedBody.contains(notes)) {
        lines.add('الشكوى: $notes');
      }
      if (fee != null && fee.isNotEmpty && !resolvedBody.contains(fee)) {
        final payStr =
            payment != null && payment.isNotEmpty ? ' ($payment)' : '';
        lines.add('الرسوم: $fee ج.م$payStr');
      }

      if (lines.isNotEmpty) {
        if (resolvedBody.isEmpty ||
            resolvedBody == 'New appointment' ||
            resolvedBody == 'لديك طلب حجز جديد' ||
            resolvedBody == 'طلب حجز جديد') {
          resolvedBody = lines.join(' | ');
        } else if (!lines.every((l) => resolvedBody.contains(l))) {
          resolvedBody = '$resolvedBody\n${lines.join(' | ')}';
        }
      }
    }

    return DoctorNotificationModel(
      id: (json['id'] ?? json['notification_id'] ?? json['_id'] ?? '')
          .toString(),
      title: resolvedTitle,
      body: resolvedBody,
      time: (json['time'] ??
              json['created_at'] ??
              json['createdAt'] ??
              json['timestamp'] ??
              '')
          .toString(),
      isRead:
          isReadVal is bool ? isReadVal : (isReadVal == 1 || isReadVal == '1'),
      priority:
          (json['priority'] ?? json['priority_level'] ?? 'Low').toString(),
      type: (json['type'] ?? json['notification_type'] ?? 'system').toString(),
      data: dataMap,
      timeAgo: (json['time_ago'] ?? json['timeAgo'])?.toString(),
      isPinned: isPinnedVal is bool
          ? isPinnedVal
          : (isPinnedVal == 1 || isPinnedVal == '1'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'time': time,
      'isRead': isRead,
      'priority': priority,
      'type': type,
      if (data != null) 'data': data,
      if (timeAgo != null) 'time_ago': timeAgo,
      'is_pinned': isPinned,
    };
  }

  DoctorNotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    String? time,
    bool? isRead,
    String? priority,
    String? type,
    Map<String, dynamic>? data,
    String? timeAgo,
    bool? isPinned,
  }) {
    return DoctorNotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
      priority: priority ?? this.priority,
      type: type ?? this.type,
      data: data ?? this.data,
      timeAgo: timeAgo ?? this.timeAgo,
      isPinned: isPinned ?? this.isPinned,
    );
  }
}
