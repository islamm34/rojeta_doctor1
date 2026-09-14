import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import 'appointment_details_note_image_item.dart';

class AppointmentDetailsMedicalNotesCard extends StatelessWidget {
  final List<String> images;

  const AppointmentDetailsMedicalNotesCard({
    super.key,
    required this.images,
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
            children: [
              Icon(
                Icons.photo_library_outlined,
                size: 18.sp,
                color: Colors.teal.shade700,
              ),
              SizedBox(width: 8.w),
              Text(
                context.strings.medicalNotes,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 15.sp,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.teal.shade100),
                ),
                child: Text(
                  '${images.length}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.teal.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              for (final img in images)
                AppointmentDetailsNoteImageItem(imageUrl: img),
            ],
          ),
        ],
      ),
    );
  }
}
