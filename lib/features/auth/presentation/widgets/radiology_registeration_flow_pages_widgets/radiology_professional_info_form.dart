import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../../../../shared/widgets/custom_textfield.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class RadiologyProfessionalInfoForm extends StatelessWidget {
  const RadiologyProfessionalInfoForm({super.key});

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

          // License Number *
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) =>
                previous.medicalLicenseNumber != current.medicalLicenseNumber,
            builder: (context, state) {
              return CustomTextField(
                label: context.strings.licenseNumber,
                hintText: context.strings.licenseNumberHint,
                onChanged: (val) => context.read<AuthBloc>().add(
                  MedicalLicenseChangedEvent(val),
                ),
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
                hintText:
                    context.strings.organizationAboutHint,
                minLines: 3,
                maxLines: 5,
                onChanged: (val) =>
                    context.read<AuthBloc>().add(AboutChangedEvent(val)),
              );
            },
          ),
        ],
      ),
    );
  }
}
