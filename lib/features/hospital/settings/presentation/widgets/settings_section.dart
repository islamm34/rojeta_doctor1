import 'package:flutter/material.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';

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
        Padding(
          padding: EdgeInsets.only(left: 16.w, bottom: 8.h, top: 16.h),
          child: Text(
            title.toUpperCase(),
            style: context.textTheme.labelMedium?.copyWith(
              color: const Color(0xFF7A8FA6),
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(12.r),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
