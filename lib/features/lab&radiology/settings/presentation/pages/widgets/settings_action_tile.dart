import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class SettingsActionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool hasDivider;

  const SettingsActionTile({
    super.key,
    required this.title,
    required this.onTap,
    this.hasDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF0F2D52),
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Color(0xFF7A8FA6)),
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
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
