import 'package:flutter/material.dart';
import '../../data/models/doctor_chat_models.dart';

class ConversationListItem extends StatelessWidget {
  final DoctorConversationModel conversation;
  final VoidCallback onTap;

  const ConversationListItem({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avatar = conversation.patientAvatar;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
              backgroundImage: avatar != null && avatar.startsWith('http')
                  ? NetworkImage(avatar)
                  : null,
              child: avatar == null || !avatar.startsWith('http')
                  ? Icon(Icons.person, color: theme.colorScheme.primary)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        conversation.patientName,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        conversation.lastMessageTime,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: conversation.unreadCount > 0
                                ? Colors.black87
                                : Colors.grey.shade600,
                            fontWeight: conversation.unreadCount > 0
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (conversation.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            conversation.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
