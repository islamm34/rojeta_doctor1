import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class SettingsSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool hasDivider;

  const SettingsSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.hasDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          value: value,
          onChanged: onChanged,
          title: Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF0F2D52),
              fontWeight: FontWeight.w500,
            ),
          ),
          activeColor: Colors.white,
          activeTrackColor: const Color(0xFF1877F2),
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: const Color(0xFFE2E8F0),
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
