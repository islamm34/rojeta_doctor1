import 'package:flutter/material.dart';

import '../../../../core/utils/screen_util_like.dart';

class RegisterationStepsIndicator extends StatelessWidget {
  const RegisterationStepsIndicator({super.key, required this.progress});
  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.grey.shade200,
      valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
      minHeight: 4.h,
    );
  }
}
