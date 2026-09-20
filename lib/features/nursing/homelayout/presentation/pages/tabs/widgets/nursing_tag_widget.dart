import 'package:flutter/material.dart';

import '../../../../../../../core/utils/screen_util_like.dart';

class NursingTagWidget extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const NursingTagWidget({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
