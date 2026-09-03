import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class PatientMedicalInfoContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> items;
  final Color iconColor;
  final Color backgroundColor;
  final Color chipColor;
  final Color chipTextColor;

  const PatientMedicalInfoContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.items,
    required this.iconColor,
    required this.backgroundColor,
    required this.chipColor,
    required this.chipTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: chipColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20.r),
              SizedBox(width: 8.w),
              Text(
                title,
                style: context.textTheme.titleSmall?.copyWith(
                      color: iconColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: items.map((item) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: chipColor),
                ),
                child: Text(
                  item,
                  style: context.textTheme.bodyMedium?.copyWith(
                        color: chipTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
