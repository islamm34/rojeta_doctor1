import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import '../../../../../../shared/widgets/custom_textfield.dart';
import '../../data/models/profile_model.dart';

class BasicInfoSection extends StatelessWidget {
  final ProfileModel profile;

  const BasicInfoSection({super.key, required this.profile});

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
            initialValue: profile.fullName,
            enabled: false, // assuming this is read-only or editable elsewhere
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.email,
            initialValue: profile.email,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: context.strings.phone,
            initialValue: profile.phone,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}
