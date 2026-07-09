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
    return DoctorNotificationModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      time: json['time'] as String? ?? '',
      isRead: json['isRead'] as bool? ?? false,
      priority: json['priority'] as String? ?? 'Low',
      type: json['type'] as String? ?? 'system',
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
