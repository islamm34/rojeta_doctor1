import 'package:equatable/equatable.dart';

class DoctorConversationModel extends Equatable {
  final String id;
  final String patientId;
  final String patientName;
  final String? patientAvatar;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;

  const DoctorConversationModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    this.patientAvatar,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });

  factory DoctorConversationModel.fromJson(Map<String, dynamic> json) {
    final patientObj = json['patient'] is Map<String, dynamic>
        ? json['patient'] as Map<String, dynamic>
        : (json['user'] is Map<String, dynamic>
            ? json['user'] as Map<String, dynamic>
            : null);

    final patientId = (json['patientId'] ??
            json['patient_id'] ??
            patientObj?['id'] ??
            json['user_id'] ??
            '')
        .toString();

    final patientName = (json['patientName'] ??
            json['patient_name'] ??
            patientObj?['name'] ??
            patientObj?['full_name'] ??
            json['name'] ??
            'Patient')
        .toString();

    final patientAvatar = (json['patientAvatar'] ??
            json['patient_avatar'] ??
            patientObj?['avatar'] ??
            patientObj?['image'] ??
            patientObj?['profile_picture'])
        ?.toString();

    String lastMsg = '';
    if (json['last_message'] is Map<String, dynamic>) {
      final msgObj = json['last_message'] as Map<String, dynamic>;
      lastMsg = (msgObj['content'] ?? msgObj['message'] ?? msgObj['body'] ?? '')
          .toString();
    } else if (json['last_message'] != null) {
      lastMsg = json['last_message'].toString();
    } else if (json['lastMessage'] != null) {
      lastMsg = json['lastMessage'].toString();
    } else if (json['message'] != null) {
      lastMsg = json['message'].toString();
    }

    final lastMessageTime = (json['lastMessageTime'] ??
            json['last_message_time'] ??
            json['updated_at'] ??
            json['created_at'] ??
            '')
        .toString();

    final unreadCount = (json['unreadCount'] ??
            json['unread_count'] ??
            json['unread_messages_count'] ??
            0) as num;

    return DoctorConversationModel(
      id: json['id']?.toString() ?? '',
      patientId: patientId,
      patientName: patientName,
      patientAvatar: patientAvatar,
      lastMessage: lastMsg,
      lastMessageTime: lastMessageTime,
      unreadCount: unreadCount.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'patientName': patientName,
      'patientAvatar': patientAvatar,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'unreadCount': unreadCount,
    };
  }

  DoctorConversationModel copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? patientAvatar,
    String? lastMessage,
    String? lastMessageTime,
    int? unreadCount,
  }) {
    return DoctorConversationModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      patientAvatar: patientAvatar ?? this.patientAvatar,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        patientId,
        patientName,
        patientAvatar,
        lastMessage,
        lastMessageTime,
        unreadCount,
      ];
}

class DoctorChatMessageModel extends Equatable {
  final String id;
  final String senderId;
  final String senderRole;
  final String content;
  final String createdAt;
  final bool isMe;

  const DoctorChatMessageModel({
    required this.id,
    required this.senderId,
    required this.senderRole,
    required this.content,
    required this.createdAt,
    required this.isMe,
  });

  factory DoctorChatMessageModel.fromJson(Map<String, dynamic> json) {
    final senderRole = (json['senderRole'] ??
            json['sender_role'] ??
            json['role'] ??
            '')
        .toString();

    final isMeVal = json['isMe'] == true ||
        json['is_me'] == true ||
        senderRole.toLowerCase() == 'doctor';

    return DoctorChatMessageModel(
      id: json['id']?.toString() ?? '',
      senderId: (json['senderId'] ?? json['sender_id'] ?? json['user_id'] ?? '')
          .toString(),
      senderRole: senderRole,
      content: (json['content'] ??
              json['message'] ??
              json['body'] ??
              json['text'] ??
              '')
          .toString(),
      createdAt: (json['createdAt'] ??
              json['created_at'] ??
              json['time'] ??
              '')
          .toString(),
      isMe: isMeVal,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'senderRole': senderRole,
      'content': content,
      'createdAt': createdAt,
      'isMe': isMe,
    };
  }

  @override
  List<Object?> get props => [id, senderId, senderRole, content, createdAt, isMe];
}
