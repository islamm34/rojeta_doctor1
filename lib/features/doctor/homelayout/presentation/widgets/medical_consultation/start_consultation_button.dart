import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../shared/widgets/custom_elevated_button.dart';

class StartConsultationButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isInProgress;

  const StartConsultationButton({
    super.key,
    this.onPressed,
    this.isInProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: context.strings.startConsultation,
      backgroundColor: isInProgress
          ? const Color(0xFF0288D1)
          : const Color(0xFF00C853),
      borderRadius: 12.r,
      icon: Icon(
        isInProgress ? Icons.check_circle_outline : Icons.play_arrow_outlined,
        color: Colors.white,
        size: 20.sp,
      ),
      onPressed: onPressed,
    );
  }
}
