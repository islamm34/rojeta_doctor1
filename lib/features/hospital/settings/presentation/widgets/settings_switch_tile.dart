import 'package:flutter/material.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';

class SettingsSwitchTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchTile({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      leading: icon != null ? Icon(icon, color: const Color(0xFF1877F2)) : null,
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0F2D52),
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF7A8FA6),
                height: 1.2,
              ),
            )
          : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: Colors.white,
        activeTrackColor: const Color(0xFF1877F2),
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: const Color(0xFFE2E8F0),
        trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          return Colors.transparent;
        }),
      ),
    );
  }
}
