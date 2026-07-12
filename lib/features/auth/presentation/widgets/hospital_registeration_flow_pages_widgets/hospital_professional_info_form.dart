import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/image_picker_helper.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_textfield.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';
import 'hospital_image_upload_tile.dart';

class HospitalProfessionalInfoForm extends StatelessWidget {
  const HospitalProfessionalInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
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
              Icon(Icons.business_outlined, color: theme.colorScheme.primary),
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

          // Organization Name *
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.organizationName != c.organizationName,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.organizationName,
                hintText: context.strings.organizationNameHint,
                isRequired: true,
                onChanged: (val) => context.read<AuthBloc>().add(
                  OrganizationNameChangedEvent(val),
                ),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Organization Type *
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.organizationType != c.organizationType,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.organizationType,
                hintText: context.strings.organizationTypeHint,
                isRequired: true,
                onChanged: (val) => context.read<AuthBloc>().add(
                  OrganizationTypeChangedEvent(val),
                ),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Organization Number *
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.organizationNumber != c.organizationNumber,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.organizationNumber,
                hintText: context.strings.organizationNumberHint,
                isRequired: true,
                keyboardType: TextInputType.phone,
                onChanged: (val) => context.read<AuthBloc>().add(
                  OrganizationNumberChangedEvent(val),
                ),
              );
            },
          ),

          SizedBox(height: 16.h),

          // License Number *
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) =>
                p.medicalLicenseNumber != c.medicalLicenseNumber,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.licenseNumber,
                hintText: context.strings.licenseNumberHint,
                isRequired: true,
                onChanged: (val) => context.read<AuthBloc>().add(
                  MedicalLicenseChangedEvent(val),
                ),
              );
            },
          ),

          SizedBox(height: 16.h),

          // About
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.about != c.about,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.about,
                hintText: context.strings.organizationAboutHint,
                minLines: 3,
                maxLines: 5,
                onChanged: (val) =>
                    context.read<AuthBloc>().add(AboutChangedEvent(val)),
              );
            },
          ),

          SizedBox(height: 24.h),

          // Organization Logo
          Text(
            context.strings.organizationLogo,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) => p.profileImagePath != c.profileImagePath,
            builder: (context, state) {
              return HospitalImageUploadTile(
                imagePath: state.profileImagePath,
                onTap: () async {
                  final path = await ImagePickerHelper.pickImagePath();
                  if (path != null) {
                    context.read<AuthBloc>().add(PickProfileImageEvent(path));
                  }
                },
              );
            },
          ),

          SizedBox(height: 24.h),

          // Organization Images
          Text(
            context.strings.organizationImages,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          // ponytail: single image placeholder; upgrade to multi-image grid when backend supports multiple uploads.
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (p, c) =>
                p.organizationImagePath != c.organizationImagePath,
            builder: (context, state) {
              return HospitalImageUploadTile(
                imagePath: state.organizationImagePath,
                onTap: () async {
                  final path = await ImagePickerHelper.pickImagePath();
                  if (path != null) {
                    context.read<AuthBloc>().add(
                      PickOrganizationImageEvent(path),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
