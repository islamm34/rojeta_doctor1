import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/image_picker_helper.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_textfield.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';
import 'specialty_dropdown_field.dart';
import 'sub_specialty_dropdown_field.dart';
import '../location/city_dropdown_field.dart';
import '../location/governorate_dropdown_field.dart';
import '../location/map_location_picker_button.dart';

class ProfessionalInfoForm extends StatefulWidget {
  const ProfessionalInfoForm({super.key});

  @override
  State<ProfessionalInfoForm> createState() => _ProfessionalInfoFormState();
}

class _ProfessionalInfoFormState extends State<ProfessionalInfoForm> {
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(
      text: context.read<AuthBloc>().state.fullAddress,
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.fullAddress != current.fullAddress,
      listener: (context, state) {
        if (_addressController.text != state.fullAddress) {
          _addressController.text = state.fullAddress;
        }
      },
      child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
              Icon(
                Icons.workspace_premium_outlined,
                color: theme.colorScheme.primary,
              ),
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
              buildWhen: (previous, current) =>
                  previous.profileImagePath != current.profileImagePath,
              builder: (context, state) {
                return GestureDetector(
                  onTap: () async {
                    final path = await ImagePickerHelper.pickImagePath();
                    if (path != null && context.mounted) {
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
                                  image: FileImage(
                                    File(state.profileImagePath!),
                                  ),
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
                                color: Colors.black.withValues(alpha: 0.1),
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
          const SpecialtyDropdownField(),

          SizedBox(height: 16.h),

          // Sub-Specialty
          const SubSpecialtyDropdownField(),

          SizedBox(height: 16.h),

          // Governorate
          const GovernorateDropdownField(isRequired: false),

          SizedBox(height: 16.h),

          // City / Area
          const CityDropdownField(isRequired: false),

          SizedBox(height: 16.h),

          // Clinic / Institution Full Address
          CustomTextField(
            label: context.strings.fullAddress,
            hintText: context.strings.fullAddressHint,
            controller: _addressController,
            minLines: 2,
            maxLines: 3,
            onChanged: (val) =>
                context.read<AuthBloc>().add(FullAddressChangedEvent(val)),
          ),

          SizedBox(height: 16.h),

          // + Location (Choose on Map)
          MapLocationPickerButton(
            onLocationChanged: (loc) {
              if (loc.address?.isNotEmpty == true) {
                _addressController.text = loc.address!;
              }
            },
          ),

          SizedBox(height: 16.h),

          // Medical License Number
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) =>
                previous.medicalLicenseNumber != current.medicalLicenseNumber,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.medicalLicenseNumber,
                hintText: context.strings.medicalLicenseHint,
                onChanged: (val) => context.read<AuthBloc>().add(
                  MedicalLicenseChangedEvent(val),
                ),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Years of Experience *
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) =>
                previous.yearsOfExperience != current.yearsOfExperience,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.yearsOfExperience,
                hintText: context.strings.yearsOfExperienceHint,
                isRequired: true,
                keyboardType: TextInputType.number,
                onChanged: (val) => context.read<AuthBloc>().add(
                  YearsOfExperienceChangedEvent(val),
                ),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Education & Certifications
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) =>
                previous.education != current.education,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.educationAndCertifications,
                hintText: context.strings.educationHint,
                minLines: 3,
                maxLines: 5,
                onChanged: (val) =>
                    context.read<AuthBloc>().add(EducationChangedEvent(val)),
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
                onChanged: (val) =>
                    context.read<AuthBloc>().add(AboutChangedEvent(val)),
              );
            },
          ),
        ],
      ),
    ),
    );
  }
}
