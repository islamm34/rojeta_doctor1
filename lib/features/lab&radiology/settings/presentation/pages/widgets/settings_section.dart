import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class SettingsItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color iconColor;
  final Color iconBgColor;
  final bool hasDivider;
  final Widget? trailing;

  const SettingsItemTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    required this.iconColor,
    required this.iconBgColor,
    this.hasDivider = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: iconColor, size: 20.r),
          ),
          title: Text(
            title,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2D52),
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF7A8FA6),
                  ),
                )
              : null,
          trailing: trailing ?? Icon(Icons.chevron_right, color: const Color(0xFF7A8FA6), size: 20.r),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: subtitle != null ? 4.h : 0),
        ),
        if (hasDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: const Color(0xFFE2E8F0),
            indent: 16.w,
            endIndent: 16.w,
          ),
      ],
    );
  }
}
