import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../core/utils/screen_util_like.dart';
import 'medical_note_preview_dialog.dart';

class MedicalNoteImageThumbnail extends StatelessWidget {
  final String imagePath;
  final VoidCallback onRemove;

  const MedicalNoteImageThumbnail({
    super.key,
    required this.imagePath,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => MedicalNotePreviewDialog(imagePath: imagePath),
            );
          },
          child: Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.grey.shade100,
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Colors.grey.shade500,
                  size: 24.sp,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: -6.h,
          right: -6.w,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.red.shade600,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.close, color: Colors.white, size: 12.sp),
            ),
          ),
        ),
      ],
    );
  }
}
