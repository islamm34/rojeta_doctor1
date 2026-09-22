import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/core/error/exceptions.dart';

import '../../data/repositories/doctor_chat_repository.dart';
import 'doctor_chat_event.dart';
import 'doctor_chat_state.dart';

class DoctorChatBloc extends Bloc<DoctorChatEvent, DoctorChatState> {
  final DoctorChatRepository repository;
  Timer? _pollingTimer;

  DoctorChatBloc({required this.repository}) : super(const DoctorChatState()) {
    on<FetchConversationsEvent>(_onFetchConversations);
    on<SelectConversationEvent>(_onSelectConversation);
    on<SendMessageEvent>(_onSendMessage);
    on<MarkConversationReadEvent>(_onMarkConversationRead);
    on<StartPollingMessagesEvent>(_onStartPollingMessages);
    on<StopPollingMessagesEvent>(_onStopPollingMessages);
    on<PollMessagesEvent>(_onPollMessages);
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }

  Future<void> _onFetchConversations(
    FetchConversationsEvent event,
    Emitter<DoctorChatState> emit,
  ) async {
    emit(state.copyWith(status: DoctorChatStatus.loading, errorMessage: null));
    try {
      final conversations = await repository.getConversations();
      emit(
        state.copyWith(
          status: DoctorChatStatus.success,
          conversations: conversations,
        ),
      );
    } catch (e) {
      final errorMessage = e is ServerException
          ? e.message
          : (e is NetworkException ? e.message : e.toString());
      emit(
        state.copyWith(
          status: DoctorChatStatus.failure,
          errorMessage: errorMessage,
        ),
      );
    }
  }

  Future<void> _onSelectConversation(
    SelectConversationEvent event,
    Emitter<DoctorChatState> emit,
  ) async {
    emit(
      state.copyWith(
        status: DoctorChatStatus.loading,
        activeConversationId: event.conversationId,
        errorMessage: null,
      ),
    );
    try {
      final messages = await repository.getMessages(
        conversationId: event.conversationId,
      );
      emit(
        state.copyWith(
          status: DoctorChatStatus.success,
          activeMessages: messages,
        ),
      );
      // Mark as read in background
      add(MarkConversationReadEvent(event.conversationId));
    } catch (e) {
      final errorMessage = e is ServerException
          ? e.message
          : (e is NetworkException ? e.message : e.toString());
      emit(
        state.copyWith(
          status: DoctorChatStatus.failure,
          errorMessage: errorMessage,
        ),
      );
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<DoctorChatState> emit,
  ) async {
    if (event.content.trim().isEmpty) return;
    emit(state.copyWith(isSendingMessage: true));
    try {
      final sentMessage = await repository.sendMessage(
        conversationId: event.conversationId,
        content: event.content.trim(),
      );
      final messageToAdd = sentMessage.isMe
          ? sentMessage
          : sentMessage.copyWith(isMe: true);
      final updatedMessages = [...state.activeMessages, messageToAdd];
      emit(
        state.copyWith(
          isSendingMessage: false,
          activeMessages: updatedMessages,
        ),
      );
    } catch (e) {
      final errorMessage = e is ServerException
          ? e.message
          : (e is NetworkException ? e.message : e.toString());
      emit(state.copyWith(isSendingMessage: false, errorMessage: errorMessage));
    }
  }

  Future<void> _onMarkConversationRead(
    MarkConversationReadEvent event,
    Emitter<DoctorChatState> emit,
  ) async {
    try {
      await repository.markAsRead(conversationId: event.conversationId);
      final updated = state.conversations.map((c) {
        if (c.id == event.conversationId) {
          return c.copyWith(unreadCount: 0);
        }
        return c;
      }).toList();
      emit(state.copyWith(conversations: updated));
    } catch (_) {}
  }

  void _onStartPollingMessages(
    StartPollingMessagesEvent event,
    Emitter<DoctorChatState> emit,
  ) {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      add(PollMessagesEvent(event.conversationId));
    });
  }

  void _onStopPollingMessages(
    StopPollingMessagesEvent event,
    Emitter<DoctorChatState> emit,
  ) {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Future<void> _onPollMessages(
    PollMessagesEvent event,
    Emitter<DoctorChatState> emit,
  ) async {
    try {
      final messages = await repository.getMessages(
        conversationId: event.conversationId,
      );
      if (messages.length != state.activeMessages.length ||
          (messages.isNotEmpty &&
              state.activeMessages.isNotEmpty &&
              messages.last.id != state.activeMessages.last.id)) {
        emit(
          state.copyWith(
            status: DoctorChatStatus.success,
            activeMessages: messages,
          ),
        );
      }
    } catch (_) {}
  }
}
