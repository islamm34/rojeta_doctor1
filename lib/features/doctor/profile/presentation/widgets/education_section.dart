import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import '../../../../../../shared/widgets/custom_textfield.dart';
import '../../data/models/profile_model.dart';

class EducationSection extends StatelessWidget {
  final ProfileModel profile;
  final TextEditingController? educationController;

  const EducationSection({
    super.key,
    required this.profile,
    this.educationController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                Icons.school_outlined,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                context.strings.education,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hintText: context.strings.educationHint,
            controller: educationController,
            initialValue: educationController == null
                ? profile.education
                : null,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
