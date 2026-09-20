import 'package:flutter/material.dart';

import '../../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../../core/utils/screen_util_like.dart';

class NursingServiceBulletPoint extends StatelessWidget {
  final String text;

  const NursingServiceBulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.h, right: 8.w),
          child: Container(
            width: 4.r,
            height: 4.r,
            decoration: const BoxDecoration(
              color: Color(0xFF64748B),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.labelMedium?.copyWith(
              color: const Color(0xFF475569),
            ),
          ),
        ),
      ],
    );
  }
}
