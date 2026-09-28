import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class NursingCoverageEmptyState extends StatelessWidget {
  final VoidCallback onAddPressed;

  const NursingCoverageEmptyState({
    super.key,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.map_outlined,
                size: 48.w,
                color: const Color(0xFF94A3B8),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              strings.coverageAreas,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              strings.coverageZones,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF64748B),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
              onPressed: onAddPressed,
              icon: Icon(Icons.add, size: 18.w, color: Colors.white),
              label: Text(
                strings.addArea,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
