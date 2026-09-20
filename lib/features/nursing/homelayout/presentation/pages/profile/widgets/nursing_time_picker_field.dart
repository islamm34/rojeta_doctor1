import 'package:flutter/material.dart';

import '../../../../../../../core/utils/screen_util_like.dart';

class NursingTimePickerField extends StatelessWidget {
  final String label;
  final String time;
  final VoidCallback onTap;

  const NursingTimePickerField({
    super.key,
    required this.label,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: const Color(0xFF475569),
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 6.h),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFCBD5E1)),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time, style: const TextStyle(color: Color(0xFF0F172A))),
                Icon(
                  Icons.access_time,
                  color: const Color(0xFF64748B),
                  size: 18.w,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
