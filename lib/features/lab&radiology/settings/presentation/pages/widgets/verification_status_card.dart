import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class VerificationStatusCard extends StatelessWidget {
  final bool isRadiology;
  final String? year;

  const VerificationStatusCard({
    super.key,
    required this.isRadiology,
    this.year,
  });

  @override
  Widget build(BuildContext context) {
    final displayYear = year ?? DateTime.now().year.toString();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2FE),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: const BoxDecoration(
              color: Color(0xFFBAE6FD),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.verified_outlined,
              color: const Color(0xFF0369A1),
              size: 28.r,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Verification Status',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2D52),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your ${isRadiology ? 'Radiology Center' : 'lab'} is currently verified for the $displayYear calendar year.',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF475569),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFF5EEAD4),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'ACTIVE STATUS',
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F766E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
