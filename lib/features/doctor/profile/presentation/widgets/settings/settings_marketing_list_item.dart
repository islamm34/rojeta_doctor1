import 'package:flutter/material.dart';

class SettingsMarketingListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const SettingsMarketingListItem({
    super.key,
    required this.icon,
    required this.text,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey.shade800),
            ),
          ),
        ],
      ),
    );
  }
}
