import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/shared/widgets/custom_elevated_button.dart';

class ConsultationActionButtons extends StatelessWidget {
  final VoidCallback? onSaveDraft;
  final VoidCallback? onComplete;
  final bool isLoading;

  const ConsultationActionButtons({
    super.key,
    this.onSaveDraft,
    this.onComplete,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: isLoading ? null : onSaveDraft,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue,
              side: const BorderSide(color: Colors.blue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 16.h),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.save_outlined, size: 18.sp),
                SizedBox(width: 8.w),
                Text(
                  context.strings.saveDraft,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: CustomElevatedButton(
            text: context.strings.completeBtn,
            backgroundColor: const Color(0xFF00B0FF),
            borderRadius: 12.r,
            height: 52.h,
            isLoading: isLoading,
            icon: Icon(Icons.send_outlined, color: Colors.white, size: 18.sp),
            onPressed: isLoading ? null : onComplete,
          ),
        ),
      ],
    );
  }
}
