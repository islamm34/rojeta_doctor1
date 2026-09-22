import 'package:flutter/material.dart';

import '../../../../../../../core/utils/extensions/context_extensions.dart';

class SupportContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? secondarySubtitle;
  final VoidCallback onTap;

  const SupportContactTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.secondarySubtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: context.colors.primary.withValues(alpha: 0.1),
              child: Icon(icon, color: context.colors.primary, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    textDirection: .ltr,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  if (secondarySubtitle != null &&
                      secondarySubtitle!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      secondarySubtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
