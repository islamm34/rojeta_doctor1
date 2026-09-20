import 'package:flutter/material.dart';

import '../../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../../core/utils/screen_util_like.dart';

class NursingSettingsNavItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const NursingSettingsNavItem({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF475569),
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF94A3B8),
              size: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}
