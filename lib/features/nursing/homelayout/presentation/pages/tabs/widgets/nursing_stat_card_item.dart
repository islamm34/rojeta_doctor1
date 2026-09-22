import 'package:flutter/material.dart';

import '../../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../../core/utils/screen_util_like.dart';

class NursingStatCardItem extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color subtitleColor;
  final Color borderLeftColor;

  const NursingStatCardItem({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.subtitleColor,
    required this.borderLeftColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: -12.w,
            top: -12.w,
            bottom: -12.w,
            child: Container(width: 4.w, color: borderLeftColor),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF64748B),
                        letterSpacing: 1.0,
                        fontSize: 10.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(icon, color: const Color(0xFF64748B), size: 16.r),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                value,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: borderLeftColor,
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Row(
                  children: [
                    if (subtitle.contains('+'))
                      Icon(Icons.trending_up, color: subtitleColor, size: 12.r),
                    if (subtitle.contains('+')) SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        subtitle,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: subtitleColor,
                          fontSize: 10.sp,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
