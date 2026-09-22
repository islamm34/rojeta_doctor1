import 'package:flutter/material.dart';

import '../../../../../core/utils/extensions/time_extensions.dart';
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
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message.content ?? '',
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTimestamp(context, message.createdAt ?? message.timestamp),
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

  String _formatTimestamp(BuildContext context, String? raw) {
    if (raw == null || raw.trim().isEmpty) return '';
    final trimmed = raw.trim();

    final parsed = DateTime.tryParse(trimmed);
    if (parsed != null) {
      final local = parsed.toLocal();
      final hasTimeComponent = trimmed.contains(':') || trimmed.contains('T');
      if (hasTimeComponent) {
        final timeStr =
            '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
        return TimeFormatter.formatDateTime(local, timeStr, context: context);
      } else {
        return TimeFormatter.formatDate(local, context: context);
      }
    }

    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2 && parts.any((p) => p.contains(':'))) {
      final datePart = parts[0];
      final timePart = parts.sublist(1).join(' ');
      return TimeFormatter.formatDateTime(datePart, timePart, context: context);
    }

    final formattedTime = TimeFormatter.formatTo12Hour(
      trimmed,
      context: context,
    );
    if (formattedTime.isNotEmpty && formattedTime != trimmed) {
      return formattedTime;
    }

    return TimeFormatter.formatDateTime(trimmed, null, context: context);
  }
}
