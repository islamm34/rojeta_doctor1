import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import '../../../../../../shared/widgets/custom_textfield.dart';
import '../../data/models/profile_model.dart';

class ProfessionalInfoSection extends StatelessWidget {
  final ProfileModel profile;

  const ProfessionalInfoSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.workspace_premium_outlined, color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                context.strings.professionalInformation,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: context.strings.specialty,
            initialValue: profile.specialty,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.subSpecialty,
            hintText: context.strings.subSpecialtyHint,
            initialValue: profile.subSpecialty,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.yearsOfExperience,
            hintText: context.strings.yearsOfExperienceHint,
            initialValue: profile.yearsOfExperience,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.about,
            hintText: context.strings.aboutHint,
            initialValue: profile.about,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
