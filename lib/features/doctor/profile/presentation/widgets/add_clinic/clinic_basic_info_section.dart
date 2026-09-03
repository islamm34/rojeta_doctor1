import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import 'clinic_labeled_text_field.dart';

class ClinicBasicInfoSection extends StatelessWidget {
  const ClinicBasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.basicInformation,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ClinicLabeledTextField(
          label: strings.clinicName,
          hint: strings.clinicNameHint,
        ),
        const SizedBox(height: 16),
        ClinicLabeledTextField(
          label: strings.clinicPhone,
          hint: strings.clinicPhoneHint,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ClinicLabeledTextField(
                label: strings.governorate,
                hint: '',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ClinicLabeledTextField(
                label: strings.city,
                hint: '',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ClinicLabeledTextField(
          label: strings.fullAddress,
          hint: strings.fullAddressHint,
          maxLines: 2,
        ),
      ],
    );
  }
}
