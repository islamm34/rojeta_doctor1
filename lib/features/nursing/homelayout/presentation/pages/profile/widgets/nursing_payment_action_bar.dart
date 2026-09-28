import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class NursingPaymentActionBar extends StatelessWidget {
  final VoidCallback onDiscard;
  final VoidCallback onSave;

  const NursingPaymentActionBar({
    super.key,
    required this.onDiscard,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Container(
      color: const Color(0xFFF8FAFC),
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: const Color(0xFF64748B),
                size: 16.w,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  strings.unsavedChangesWarning,
                  style: TextStyle(
                    color: const Color(0xFF64748B),
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onDiscard,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    side: const BorderSide(color: Color(0xFF94A3B8)),
                  ),
                  child: Text(
                    strings.discard.toUpperCase(),
                    style: TextStyle(
                      color: const Color(0xFF0F2D52),
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onSave,
                  icon: Icon(
                    Icons.save_outlined,
                    color: Colors.white,
                    size: 16.w,
                  ),
                  label: Text(
                    strings.saveChanges.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
