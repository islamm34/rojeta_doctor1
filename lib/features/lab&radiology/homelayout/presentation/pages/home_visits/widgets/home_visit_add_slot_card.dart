import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class HomeVisitAddSlotCard extends StatelessWidget {
  final VoidCallback? onTap;

  const HomeVisitAddSlotCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72.w,
        height: 82.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: const Color(0xFFCBD5E1),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: const Color(0xFF0F2D52),
              size: 24.r,
            ),
            SizedBox(height: 4.h),
            Text(
              'NEW SLOT',
              style: context.textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF7A8FA6),
                    fontWeight: FontWeight.bold,
                    fontSize: 9.sp,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
