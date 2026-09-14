import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../core/utils/screen_util_like.dart';
import 'appointment_details_image_preview_dialog.dart';

class AppointmentDetailsNoteImageItem extends StatelessWidget {
  final String imageUrl;

  const AppointmentDetailsNoteImageItem({
    super.key,
    required this.imageUrl,
  });

  void _showPreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AppointmentDetailsImagePreviewDialog(imageUrl: imageUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isNetwork =
        imageUrl.startsWith('http://') || imageUrl.startsWith('https://');

    return GestureDetector(
      onTap: () => _showPreview(context),
      child: Container(
        width: 88.w,
        height: 88.w,
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFC),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (isNetwork)
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: Colors.grey.shade400,
                    size: 24.sp,
                  ),
                ),
              )
            else
              Image.file(
                File(imageUrl),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: Colors.grey.shade400,
                    size: 24.sp,
                  ),
                ),
              ),
            Positioned(
              right: 4.w,
              bottom: 4.h,
              child: Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Icon(
                  Icons.zoom_in,
                  size: 12.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
