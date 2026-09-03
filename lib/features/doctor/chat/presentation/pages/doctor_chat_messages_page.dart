import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/doctor/chat/data/models/doctor_chat_models.dart';
import '../../../../../../core/di/injector.dart';
import '../bloc/doctor_chat_bloc.dart';
import '../bloc/doctor_chat_event.dart';
import '../bloc/doctor_chat_state.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_message_bubble.dart';

class DoctorChatMessagesPage extends StatelessWidget {
  final DoctorConversationModel conversation;

  const DoctorChatMessagesPage({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          injector<DoctorChatBloc>()
            ..add(SelectConversationEvent(conversation.id)),
      child: _DoctorChatMessagesView(conversation: conversation),
    );
  }
}

class _DoctorChatMessagesView extends StatefulWidget {
  final DoctorConversationModel conversation;

  const _DoctorChatMessagesView({required this.conversation});

  @override
  State<_DoctorChatMessagesView> createState() =>
      _DoctorChatMessagesViewState();
}

class _DoctorChatMessagesViewState extends State<_DoctorChatMessagesView> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    context.read<DoctorChatBloc>().add(
      SendMessageEvent(conversationId: widget.conversation.id, content: text),
    );
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage:
                  widget.conversation.patientAvatar != null &&
                      widget.conversation.patientAvatar!.startsWith('http')
                  ? NetworkImage(widget.conversation.patientAvatar!)
                  : null,
              child:
                  widget.conversation.patientAvatar == null ||
                      !widget.conversation.patientAvatar!.startsWith('http')
                  ? const Icon(Icons.person, size: 18)
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.conversation.patientName,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<DoctorChatBloc, DoctorChatState>(
              listener: (context, state) {
                if (state.activeMessages.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                      );
                    }
                  });
                }
              },
              builder: (context, state) {
                if (state.status == DoctorChatStatus.loading &&
                    state.activeMessages.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = state.activeMessages;

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ChatMessageBubble(message: messages[index]);
                  },
                );
              },
            ),
          ),
          BlocBuilder<DoctorChatBloc, DoctorChatState>(
            builder: (context, state) {
              return ChatInputBar(
                controller: _textController,
                onSend: _sendMessage,
                isSending: state.isSendingMessage,
              );
            },
          ),
        ],
      ),
    );
  }
}
