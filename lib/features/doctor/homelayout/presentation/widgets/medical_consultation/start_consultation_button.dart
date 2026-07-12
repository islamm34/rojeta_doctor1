import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../shared/widgets/custom_elevated_button.dart';

class StartConsultationButton extends StatelessWidget {
  const StartConsultationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: context.strings.startConsultation,
      backgroundColor: const Color(0xFF00C853), // Green from UI
      borderRadius: 12.r,
      icon: Icon(Icons.play_arrow_outlined, color: Colors.white, size: 20.sp),
      onPressed: () {
        // Logic to start consultation (e.g. video call or just mark in progress)
      },
    );
  }
}
