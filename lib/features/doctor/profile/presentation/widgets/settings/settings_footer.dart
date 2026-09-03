import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class SettingsFooter extends StatelessWidget {
  const SettingsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            context.strings.rujetaDoctorApp,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            context.strings.version,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
