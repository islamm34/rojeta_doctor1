import 'package:flutter/material.dart';
import '../../../../../core/utils/screen_util_like.dart';

class UploadItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isPicked;

  const UploadItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isPicked = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: isPicked ? theme.colorScheme.primary : Colors.grey.shade300),
          color: isPicked ? theme.colorScheme.primary.withOpacity(0.05) : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPicked ? Icons.check_circle : Icons.file_upload_outlined, 
              color: isPicked ? theme.colorScheme.primary : Colors.grey.shade600, 
              size: 28.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
