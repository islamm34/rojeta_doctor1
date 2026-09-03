import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class HomeVisitSlotTab extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const HomeVisitSlotTab({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF45F5D0) : const Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          title,
          style: TextStyle(
            color:
                isActive ? const Color(0xFF0F2D52) : const Color(0xFF7A8FA6),
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
