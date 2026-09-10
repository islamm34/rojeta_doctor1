import 'package:equatable/equatable.dart';

abstract class DoctorChatEvent extends Equatable {
  const DoctorChatEvent();

  @override
  List<Object?> get props => [];
}

class FetchConversationsEvent extends DoctorChatEvent {
  const FetchConversationsEvent();
}

class SelectConversationEvent extends DoctorChatEvent {
  final String conversationId;

  const SelectConversationEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class SendMessageEvent extends DoctorChatEvent {
  final String conversationId;
  final String content;

  const SendMessageEvent({
    required this.conversationId,
    required this.content,
  });

  @override
  List<Object?> get props => [conversationId, content];
}

class MarkConversationReadEvent extends DoctorChatEvent {
  final String conversationId;

  const MarkConversationReadEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class StartPollingMessagesEvent extends DoctorChatEvent {
  final String conversationId;

  const StartPollingMessagesEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class StopPollingMessagesEvent extends DoctorChatEvent {
  const StopPollingMessagesEvent();
}

class PollMessagesEvent extends DoctorChatEvent {
  final String conversationId;

  const PollMessagesEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}
