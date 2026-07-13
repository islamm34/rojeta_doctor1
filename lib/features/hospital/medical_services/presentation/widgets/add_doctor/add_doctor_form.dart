import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../../../../../shared/widgets/custom_textfield.dart';

class AddDoctorForm extends StatelessWidget {
  const AddDoctorForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: context.strings.fullNameLabel,
          hintText: 'Dr. Ahmed Ameen',
          prefixIcon: Icon(Icons.person_outline, size: 20.w),
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          label: context.strings.professionalTitleLabel,
          hintText: context.strings.professionalTitleHint,
          prefixIcon: Icon(Icons.work_outline, size: 20.w),
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          label: context.strings.medicalLicenseNumberLabel,
          hintText: context.strings.medicalLicenseNumberHint,
          prefixIcon: Icon(Icons.verified_user_outlined, size: 20.w),
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          label: context.strings.yearsOfExperienceLabel,
          hintText: context.strings.yearsOfExperienceHint,
          prefixIcon: Icon(Icons.school_outlined, size: 20.w),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          label: context.strings.consultationFeeLabel,
          hintText: context.strings.consultationFeeHint,
          prefixIcon: Icon(Icons.money, size: 20.w),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          label: context.strings.availableDaysLabel,
          hintText: context.strings.availableDaysHint,
          prefixIcon: Icon(Icons.calendar_today_outlined, size: 20.w),
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          label: context.strings.consultationDurationLabel,
          hintText: context.strings.consultationDurationHint,
          prefixIcon: Icon(Icons.access_time_outlined, size: 20.w),
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          label: context.strings.shortBioLabel,
          hintText: context.strings.shortBioHint,
          prefixIcon: Padding(
            padding: EdgeInsets.only(bottom: 60.h),
            child: Icon(Icons.sort, size: 20.w),
          ),
          maxLines: 4,
        ),
      ],
    );
  }
}
