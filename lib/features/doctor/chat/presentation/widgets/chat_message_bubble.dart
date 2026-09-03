import 'package:flutter/material.dart';
import '../../data/models/doctor_chat_models.dart';

class ChatMessageBubble extends StatelessWidget {
  final DoctorChatMessageModel message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    final theme = Theme.of(context);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? theme.colorScheme.primary : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.createdAt,
              style: TextStyle(
                color: isMe ? Colors.white70 : Colors.grey.shade500,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
