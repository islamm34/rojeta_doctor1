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
    return DoctorConversationModel(
      id: json['id']?.toString() ?? '',
      patientId: json['patientId']?.toString() ?? '',
      patientName: json['patientName'] as String? ?? '',
      patientAvatar: json['patientAvatar'] as String?,
      lastMessage: json['lastMessage'] as String? ?? '',
      lastMessageTime: json['lastMessageTime'] as String? ?? '',
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
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
    return DoctorChatMessageModel(
      id: json['id']?.toString() ?? '',
      senderId: json['senderId']?.toString() ?? '',
      senderRole: json['senderRole'] as String? ?? '',
      content: json['content'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      isMe: json['isMe'] as bool? ?? false,
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
