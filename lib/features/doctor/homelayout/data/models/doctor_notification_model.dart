class DoctorNotificationModel {
  final String id;
  final String title;
  final String body;
  final String time;
  final bool isRead;
  final String priority; // 'High', 'Medium', 'Low'
  final String type; // 'appointment', 'payment', 'review', 'message', 'system', 'reminder', 'feature'

  const DoctorNotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
    this.priority = 'Low',
    this.type = 'system',
  });

  factory DoctorNotificationModel.fromJson(Map<String, dynamic> json) {
    final isReadVal = json['isRead'] ??
        json['is_read'] ??
        (json['read_at'] != null) ??
        (json['status'] == 'read');

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
      isRead: isReadVal is bool ? isReadVal : (isReadVal == 1 || isReadVal == '1'),
      priority: (json['priority'] ?? json['priority_level'] ?? 'Low').toString(),
      type: (json['type'] ?? json['notification_type'] ?? 'system').toString(),
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
  }) {
    return DoctorNotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
      priority: priority ?? this.priority,
      type: type ?? this.type,
    );
  }
}
