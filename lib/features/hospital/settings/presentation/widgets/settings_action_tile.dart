import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';

class SettingsActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;
  final Color? iconColor;

  const SettingsActionTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? const Color(0xFF1877F2)),
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: const Color(0xFF0F2D52),
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right_rounded, size: 24, color: Color(0xFF8E9BAE)),
      onTap: onTap,
    );
  }
}
