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

  String? get patientName =>
      (data?['patient_name'] ?? data?['patientName'])?.toString();

  String? get patientPhone =>
      (data?['patient_phone'] ?? data?['patientPhone'])?.toString();

  String? get bookingRef => (data?['booking_ref'] ??
          data?['bookingRef'] ??
          data?['booking_id'] ??
          data?['bookingId'] ??
          data?['appointment_id'])
      ?.toString();

  String? get bookingDate =>
      (data?['booking_date'] ?? data?['bookingDate'])?.toString();

  String? get bookingTime =>
      (data?['booking_time'] ?? data?['bookingTime'])?.toString();

  String? get visitType =>
      (data?['visit_type'] ?? data?['visitType'])?.toString();

  String? get route => data?['route']?.toString();

  String? get appointmentId => (data?['appointment_id'] ??
          data?['appointmentId'] ??
          data?['booking_id'] ??
          data?['bookingId'])
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

    return DoctorNotificationModel(
      id: (json['id'] ?? json['notification_id'] ?? json['_id'] ?? '')
          .toString(),
      title: (json['title'] ??
              json['header'] ??
              json['subject'] ??
              json['type'] ??
              'Notification')
          .toString(),
      body: (json['body'] ??
              json['message'] ??
              json['content'] ??
              json['text'] ??
              json['description'] ??
              '')
          .toString(),
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
