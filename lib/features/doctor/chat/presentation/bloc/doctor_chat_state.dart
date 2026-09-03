import 'package:equatable/equatable.dart';
import '../../data/models/doctor_chat_models.dart';

enum DoctorChatStatus { initial, loading, success, failure }

class DoctorChatState extends Equatable {
  final DoctorChatStatus status;
  final List<DoctorConversationModel> conversations;
  final String? activeConversationId;
  final List<DoctorChatMessageModel> activeMessages;
  final String? errorMessage;
  final bool isSendingMessage;

  const DoctorChatState({
    this.status = DoctorChatStatus.initial,
    this.conversations = const [],
    this.activeConversationId,
    this.activeMessages = const [],
    this.errorMessage,
    this.isSendingMessage = false,
  });

  DoctorChatState copyWith({
    DoctorChatStatus? status,
    List<DoctorConversationModel>? conversations,
    String? activeConversationId,
    List<DoctorChatMessageModel>? activeMessages,
    String? errorMessage,
    bool? isSendingMessage,
  }) {
    return DoctorChatState(
      status: status ?? this.status,
      conversations: conversations ?? this.conversations,
      activeConversationId: activeConversationId ?? this.activeConversationId,
      activeMessages: activeMessages ?? this.activeMessages,
      errorMessage: errorMessage,
      isSendingMessage: isSendingMessage ?? this.isSendingMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        conversations,
        activeConversationId,
        activeMessages,
        errorMessage,
        isSendingMessage,
      ];
}
