import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isSending;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    this.isSending = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: context.strings.typeYourMessage,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 4,
                minLines: 1,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              child: isSending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 18),
                      onPressed: onSend,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
