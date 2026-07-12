import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../shared/widgets/custom_elevated_button.dart';

class MedicalServicesBanner extends StatelessWidget {
  final VoidCallback? onManageTap;

  const MedicalServicesBanner({
    super.key,
    this.onManageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.strings.medicalServicesManagement,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.strings.medicalServicesDesc,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
              fontSize: 13.sp,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20.h),
          CustomElevatedButton(
            text: context.strings.manageMedicalServices,
            onPressed: onManageTap ?? () {},
            backgroundColor: const Color(0xFF28B563),
            borderRadius: 12.r,
            height: 48.h,
          ),
        ],
      ),
    );
  }
}
