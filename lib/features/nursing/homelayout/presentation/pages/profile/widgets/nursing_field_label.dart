import 'package:flutter/material.dart';

import '../../../../../../../core/utils/screen_util_like.dart';

class NursingFieldLabel extends StatelessWidget {
  final String text;

  const NursingFieldLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: const Color(0xFF475569),
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
