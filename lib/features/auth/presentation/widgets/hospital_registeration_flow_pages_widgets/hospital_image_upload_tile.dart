import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../../core/utils/screen_util_like.dart';

/// A reusable upload tile for organization logo / images.
/// Shows a dashed-border upload box when no image is picked,
/// and displays the selected image preview otherwise.
class HospitalImageUploadTile extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onTap;

  const HospitalImageUploadTile({
    super.key,
    required this.onTap,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 100.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: imagePath != null
                ? theme.colorScheme.primary
                : Colors.grey.shade300,
            style: BorderStyle.solid,
          ),
          image: imagePath != null
              ? DecorationImage(
                  image: FileImage(File(imagePath!)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: imagePath == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_outlined,
                    size: 28.sp,
                    color: Colors.grey.shade500,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Upload',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
