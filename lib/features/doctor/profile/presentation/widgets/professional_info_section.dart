import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import '../../../../auth/data/models/doctor_specialty.dart';
import '../../../../../../shared/widgets/custom_dropdown_field.dart';
import '../../../../../../shared/widgets/custom_textfield.dart';
import '../../data/models/profile_model.dart';

class ProfessionalInfoSection extends StatelessWidget {
  final ProfileModel profile;
  final TextEditingController? subSpecialtyController;
  final TextEditingController? experienceController;
  final TextEditingController? aboutController;
  final ValueChanged<DoctorSpecialty?>? onSpecialtyChanged;

  const ProfessionalInfoSection({
    super.key,
    required this.profile,
    this.subSpecialtyController,
    this.experienceController,
    this.aboutController,
    this.onSpecialtyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentSpecialty = DoctorSpecialty.fromString(profile.specialty);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.workspace_premium_outlined,
                color: theme.colorScheme.primary,
                size: 20,
              ),
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
          CustomDropdownField<DoctorSpecialty>(
            label: context.strings.specialty,
            hintText: context.strings.selectSpecialty,
            value: currentSpecialty,
            items: DoctorSpecialty.values.map((specialty) {
              return DropdownMenuItem<DoctorSpecialty>(
                value: specialty,
                child: Text(specialty.localizedName(context)),
              );
            }).toList(),
            onChanged: onSpecialtyChanged,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.subSpecialty,
            hintText: context.strings.subSpecialtyHint,
            controller: subSpecialtyController,
            initialValue: subSpecialtyController == null
                ? profile.subSpecialty
                : null,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.yearsOfExperience,
            hintText: context.strings.yearsOfExperienceHint,
            controller: experienceController,
            initialValue: experienceController == null
                ? profile.yearsOfExperience
                : null,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.about,
            hintText: context.strings.aboutHint,
            controller: aboutController,
            initialValue: aboutController == null ? profile.about : null,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
