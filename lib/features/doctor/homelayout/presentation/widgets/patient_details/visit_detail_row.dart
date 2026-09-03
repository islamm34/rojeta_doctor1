import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class VisitDetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const VisitDetailRow({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16.r, color: Colors.grey[600]),
            SizedBox(width: 8.w),
            Text(
              title,
              style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: Text(
            content,
            style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
          ),
        ),
      ],
    );
  }
}
