import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/shared/widgets/custom_elevated_button.dart';

class SettingsContactSupportSheet extends StatelessWidget {
  const SettingsContactSupportSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SettingsContactSupportSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.strings.contactSupport,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: context.colors.primary.withValues(alpha: 0.1),
              child: Icon(Icons.email_outlined, color: context.colors.primary),
            ),
            title: const Text('Email Support'),
            subtitle: const Text('support@rojeta.com'),
            onTap: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Support email: support@rojeta.com'),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: context.colors.primary.withValues(alpha: 0.1),
              child: Icon(Icons.phone_outlined, color: context.colors.primary),
            ),
            title: const Text('Phone Hotline'),
            subtitle: const Text('+20 100 000 0000 (9 AM - 6 PM)'),
            onTap: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Hotline: +20 100 000 0000'),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: context.colors.primary.withValues(alpha: 0.1),
              child: Icon(Icons.chat_outlined, color: context.colors.primary),
            ),
            title: const Text('Live Support Chat'),
            subtitle: const Text('Average response time: 5 mins'),
            onTap: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Connecting to live support...'),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          CustomElevatedButton(
            text: context.strings.close,
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
