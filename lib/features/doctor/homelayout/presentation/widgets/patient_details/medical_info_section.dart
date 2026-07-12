import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';

class MedicalInfoSection extends StatelessWidget {
  final List<String> allergies;
  final List<String> chronicConditions;

  const MedicalInfoSection({
    super.key,
    required this.allergies,
    required this.chronicConditions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.medicalInformation,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        if (allergies.isNotEmpty) ...[
          _buildInfoContainer(
            context,
            icon: Icons.error_outline,
            title: context.strings.allergies,
            items: allergies,
            iconColor: Colors.red,
            backgroundColor: const Color(0xFFFFF0F0),
            chipColor: const Color(0xFFFFE5E5),
            chipTextColor: Colors.red[700]!,
          ),
          SizedBox(height: 12.h),
        ],
        if (chronicConditions.isNotEmpty) ...[
          _buildInfoContainer(
            context,
            icon: Icons.show_chart,
            title: context.strings.chronicConditions,
            items: chronicConditions,
            iconColor: Colors.deepOrange,
            backgroundColor: const Color(0xFFFFF7ED),
            chipColor: const Color(0xFFFFEDD5),
            chipTextColor: Colors.deepOrange[700]!,
          ),
        ],
      ],
    );
  }

  Widget _buildInfoContainer(
    BuildContext context, {
    required IconData icon,
    required String title,
    required List<String> items,
    required Color iconColor,
    required Color backgroundColor,
    required Color chipColor,
    required Color chipTextColor,
  }) {
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
                  color: chipColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  item,
                  style: context.textTheme.labelMedium?.copyWith(
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
