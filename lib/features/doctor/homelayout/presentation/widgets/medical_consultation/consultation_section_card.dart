import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class ConsultationSectionCard extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Widget? titleTrailing;
  final Widget child;

  const ConsultationSectionCard({
    super.key,
    this.icon,
    required this.title,
    this.titleTrailing,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(icon, size: 16.sp, color: Colors.blue),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              if (titleTrailing != null) titleTrailing!,
            ],
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }
}
