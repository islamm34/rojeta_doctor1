import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import '../../../../data/models/nursing_staff_model.dart';

class NursingStaffCard extends StatelessWidget {
  final NursingStaffModel staff;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const NursingStaffCard({
    super.key,
    required this.staff,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = staff.status.toUpperCase() == 'AVAILABLE';

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Avatar with status dot
              Stack(
                children: [
                  Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      image: DecorationImage(
                        image: NetworkImage(staff.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        color: isAvailable ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              // Action buttons
              Row(
                children: [
                  GestureDetector(
                    onTap: onEdit,
                    child: Icon(Icons.edit_outlined, color: const Color(0xFF64748B), size: 20.w),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: onDelete,
                    child: Icon(Icons.delete_outline, color: const Color(0xFFEF4444), size: 20.w),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            staff.name,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2D52),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              _buildTag(
                text: staff.gender.toUpperCase(),
                bgColor: const Color(0xFFE2E8F0), // Or light purple as per design
                textColor: const Color(0xFF475569),
              ),
              SizedBox(width: 8.w),
              _buildTag(
                text: staff.status.toUpperCase(),
                bgColor: isAvailable ? const Color(0xFFD1FAE5) : const Color(0xFFDBEAFE),
                textColor: isAvailable ? const Color(0xFF059669) : const Color(0xFF2563EB),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Skills
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.workspace_premium_outlined, color: const Color(0xFF3B82F6), size: 18.w),
              SizedBox(width: 8.w),
              Expanded(
                child: Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: staff.skills.map((skill) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1), // Light grey
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      skill,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF475569),
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Experience
          Row(
            children: [
              Icon(Icons.work_outline, color: const Color(0xFF3B82F6), size: 18.w),
              SizedBox(width: 8.w),
              Text(
                '${staff.yearsOfExperience} yrs experience',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag({required String text, required Color bgColor, required Color textColor}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
