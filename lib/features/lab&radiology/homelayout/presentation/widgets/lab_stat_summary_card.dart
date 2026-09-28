import 'package:flutter/material.dart';

import '../../../../../core/utils/screen_util_like.dart';

class LabStatSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;
  final IconData icon;
  final String? subtitle;

  const LabStatSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.backgroundColor,
    required this.icon,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10.w,
            bottom: -10.h,
            child: Icon(
              icon,
              size: 80.w,
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 8.h),
              if (subtitle != null) ...[
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                SizedBox(height: 4.h),
              ],
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
