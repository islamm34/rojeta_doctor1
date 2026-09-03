import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class ConsultationImageNoteBox extends StatelessWidget {
  final String text;
  final VoidCallback? onOpen;

  const ConsultationImageNoteBox({
    super.key,
    required this.text,
    this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 12.sp),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onOpen ?? () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h),
              ),
              child: Text(
                context.strings.openBtn,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
