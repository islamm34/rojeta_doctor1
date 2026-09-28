import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/shared/widgets/custom_elevated_button.dart';

class SettingsTwoFactorSheet extends StatefulWidget {
  const SettingsTwoFactorSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SettingsTwoFactorSheet(),
    );
  }

  @override
  State<SettingsTwoFactorSheet> createState() => _SettingsTwoFactorSheetState();
}

class _SettingsTwoFactorSheetState extends State<SettingsTwoFactorSheet> {
  bool _is2faEnabled = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: Container(
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
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.colors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.security,
                    color: context.colors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.strings.twoFactorAuth,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _is2faEnabled
                            ? 'Two-factor authentication is active'
                            : 'Add extra security to your account',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: _is2faEnabled,
                  activeThumbColor: context.colors.primary,
                  onChanged: (val) {
                    setState(() => _is2faEnabled = val);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'When two-factor authentication is enabled, you will be prompted to enter a verification code sent to your registered phone number or email whenever you log in from a new device.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(
              text: context.strings.done,
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
