import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import 'clinic_labeled_text_field.dart';

class ClinicBasicInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController governorateController;
  final TextEditingController cityController;
  final TextEditingController addressController;

  const ClinicBasicInfoSection({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.governorateController,
    required this.cityController,
    required this.addressController,
  });

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
          controller: nameController,
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return strings.fieldRequired;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        ClinicLabeledTextField(
          label: strings.clinicPhone,
          hint: strings.clinicPhoneHint,
          keyboardType: TextInputType.phone,
          controller: phoneController,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ClinicLabeledTextField(
                label: strings.governorate,
                hint: '',
                controller: governorateController,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ClinicLabeledTextField(
                label: strings.city,
                hint: '',
                controller: cityController,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ClinicLabeledTextField(
          label: strings.fullAddress,
          hint: strings.fullAddressHint,
          maxLines: 2,
          controller: addressController,
        ),
      ],
    );
  }
}
