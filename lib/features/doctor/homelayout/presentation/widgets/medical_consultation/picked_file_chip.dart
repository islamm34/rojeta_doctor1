import 'package:flutter/material.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class PickedFileChip extends StatelessWidget {
  final String fileName;
  final VoidCallback onRemove;

  const PickedFileChip({
    super.key,
    required this.fileName,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.picture_as_pdf, size: 18.sp, color: Colors.red.shade600),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              fileName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, size: 18.sp, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
