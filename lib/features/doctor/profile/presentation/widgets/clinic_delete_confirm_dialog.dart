import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class ClinicDeleteConfirmDialog extends StatelessWidget {
  final String clinicName;

  const ClinicDeleteConfirmDialog({
    super.key,
    required this.clinicName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        strings.deleteClinic,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '${strings.confirmDeleteClinic}\n\n"$clinicName"',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            strings.cancel,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(strings.delete),
        ),
      ],
    );
  }
}
