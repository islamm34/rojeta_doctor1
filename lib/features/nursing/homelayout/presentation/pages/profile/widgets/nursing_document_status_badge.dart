import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class NursingDocumentStatusBadge extends StatelessWidget {
  final String status;

  const NursingDocumentStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final normalized = status.toLowerCase();

    Color bgColor;
    Color textColor;
    String label;
    IconData icon;

    if (normalized == 'verified' || normalized == 'approved') {
      bgColor = const Color(0xFFD1FAE5);
      textColor = const Color(0xFF065F46);
      label = strings.verifiedAccount;
      icon = Icons.check_circle_outline;
    } else if (normalized == 'rejected') {
      bgColor = const Color(0xFFFEE2E2);
      textColor = const Color(0xFF991B1B);
      label = 'Rejected';
      icon = Icons.cancel_outlined;
    } else if (normalized == 'pending') {
      bgColor = const Color(0xFFFEF3C7);
      textColor = const Color(0xFF92400E);
      label = strings.pendingVerification;
      icon = Icons.hourglass_top_outlined;
    } else {
      bgColor = const Color(0xFFF1F5F9);
      textColor = const Color(0xFF64748B);
      label = 'Not Uploaded';
      icon = Icons.upload_file_outlined;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.w, color: textColor),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
