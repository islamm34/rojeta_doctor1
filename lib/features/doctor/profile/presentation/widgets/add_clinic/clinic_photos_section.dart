import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class ClinicPhotosSection extends StatelessWidget {
  const ClinicPhotosSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(strings.clinicPhotos, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(strings.uploadUpTo6Photos, style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
        const SizedBox(height: 16),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(8),
              color: theme.colorScheme.surface,
            ),
            child: Column(
              children: [
                Icon(Icons.add_a_photo_outlined, color: theme.colorScheme.primary, size: 32),
                const SizedBox(height: 8),
                Text(strings.addPhoto, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
