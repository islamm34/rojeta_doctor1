import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class SetupStepRow extends StatelessWidget {
  final String text;
  final bool isCompleted;

  const SetupStepRow({
    super.key,
    required this.text,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? AppColors.primary : Colors.grey[400],
          size: 20.w,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: context.textTheme.bodyMedium?.copyWith(
            color: isCompleted ? Colors.black : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
