import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/image_picker_helper.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_textfield.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class ProfessionalInfoForm extends StatelessWidget {
  const ProfessionalInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.workspace_premium_outlined, color: theme.colorScheme.primary),
              SizedBox(width: 8.w),
              Text(
                context.strings.professionalInformation,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 24.h),
          
          // Image Picker Placeholder
          Center(
            child: BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) => previous.profileImagePath != current.profileImagePath,
              builder: (context, state) {
                return GestureDetector(
                  onTap: () async {
                    final path = await ImagePickerHelper.pickImagePath();
                    if (path != null) {
                      context.read<AuthBloc>().add(PickProfileImageEvent(path));
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16.r),
                          image: state.profileImagePath != null
                              ? DecorationImage(
                                  image: FileImage(File(state.profileImagePath!)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: state.profileImagePath == null
                            ? Icon(
                                Icons.person,
                                size: 40.sp,
                                color: Colors.grey.shade400,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: -4,
                        right: -4,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 16.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          SizedBox(height: 24.h),
          
          // Specialty *
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => previous.specialty != current.specialty,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.specialty,
                hintText: '',
                isRequired: true,
                onChanged: (val) => context.read<AuthBloc>().add(SpecialtyChangedEvent(val)),
              );
            },
          ),
          
          SizedBox(height: 16.h),
          
          // Sub-Specialty
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => previous.subSpecialty != current.subSpecialty,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.subSpecialty,
                hintText: context.strings.subSpecialtyHint,
                onChanged: (val) => context.read<AuthBloc>().add(SubSpecialtyChangedEvent(val)),
              );
            },
          ),
          
          SizedBox(height: 16.h),
          
          // Medical License Number
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => previous.medicalLicenseNumber != current.medicalLicenseNumber,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.medicalLicenseNumber,
                hintText: context.strings.medicalLicenseHint,
                onChanged: (val) => context.read<AuthBloc>().add(MedicalLicenseChangedEvent(val)),
              );
            },
          ),
          
          SizedBox(height: 16.h),
          
          // Years of Experience *
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => previous.yearsOfExperience != current.yearsOfExperience,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.yearsOfExperience,
                hintText: context.strings.yearsOfExperienceHint,
                isRequired: true,
                keyboardType: TextInputType.number,
                onChanged: (val) => context.read<AuthBloc>().add(YearsOfExperienceChangedEvent(val)),
              );
            },
          ),
          
          SizedBox(height: 16.h),
          
          // Education & Certifications
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => previous.education != current.education,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.educationAndCertifications,
                hintText: context.strings.educationHint,
                minLines: 3,
                maxLines: 5,
                onChanged: (val) => context.read<AuthBloc>().add(EducationChangedEvent(val)),
              );
            },
          ),
          
          SizedBox(height: 16.h),
          
          // About
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => previous.about != current.about,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.about,
                hintText: context.strings.aboutHint,
                minLines: 3,
                maxLines: 5,
                onChanged: (val) => context.read<AuthBloc>().add(AboutChangedEvent(val)),
              );
            },
          ),
        ],
      ),
    );
  }
}
