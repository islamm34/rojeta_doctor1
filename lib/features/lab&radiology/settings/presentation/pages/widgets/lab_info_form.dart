import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';
import 'package:rojeta_doctor/shared/widgets/custom_textfield.dart';

class LabInfoForm extends StatelessWidget {
  final bool isRadiology;
  final TextEditingController nameController;
  final TextEditingController licenseController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController descriptionController;

  const LabInfoForm({
    super.key,
    required this.isRadiology,
    required this.nameController,
    required this.licenseController,
    required this.emailController,
    required this.phoneController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // General Details Card
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.playlist_add_check, color: const Color(0xFF0F2D52), size: 20.r),
                  SizedBox(width: 8.w),
                  Text(
                    context.strings.generalDetails,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F2D52),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: isRadiology ? context.strings.radiologyCenterName : context.strings.labName,
                controller: nameController,
                labelStyle: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4B5563),
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: context.strings.licenseNumber,
                controller: licenseController,
                labelStyle: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4B5563),
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: context.strings.primaryContactEmail,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                labelStyle: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4B5563),
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: context.strings.phoneNumber,
                controller: phoneController,
                keyboardType: TextInputType.phone,
                labelStyle: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4B5563),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // About Card
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.description_outlined, color: const Color(0xFF0F2D52), size: 20.r),
                  SizedBox(width: 8.w),
                  Text(
                    isRadiology ? context.strings.aboutTheCenter : context.strings.aboutTheLab,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F2D52),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: isRadiology ? context.strings.radiologyDescription : context.strings.laboratoryDescription,
                controller: descriptionController,
                maxLines: 4,
                labelStyle: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4B5563),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
