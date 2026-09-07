import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import '../../../../../../shared/widgets/custom_textfield.dart';
import '../../data/models/profile_model.dart';

class BasicInfoSection extends StatelessWidget {
  final ProfileModel profile;
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;

  const BasicInfoSection({
    super.key,
    required this.profile,
    this.nameController,
    this.emailController,
    this.phoneController,
  });

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
              Icon(Icons.person_outline, color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                context.strings.basicInformation,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: context.strings.fullName,
            controller: nameController,
            initialValue: nameController == null ? profile.fullName : null,
            enabled: true,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.email,
            controller: emailController,
            initialValue: emailController == null ? profile.email : null,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.phone,
            controller: phoneController,
            initialValue: phoneController == null ? profile.phone : null,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}
