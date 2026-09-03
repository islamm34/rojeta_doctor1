import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class BranchInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const BranchInfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16.r, color: const Color(0xFF1877F2)),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF0F2D52),
                ),
          ),
        ),
      ],
    );
  }
}
