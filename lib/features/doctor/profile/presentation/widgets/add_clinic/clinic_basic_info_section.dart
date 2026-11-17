import 'package:flutter/material.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/location_picker_page.dart';
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
        const SizedBox(height: 12),
        InkWell(
          onTap: () async {
            final result = await Navigator.of(context).push<LocationResult>(
              MaterialPageRoute(builder: (_) => const LocationPickerPage()),
            );
            if (result != null) {
              if (result.address?.isNotEmpty == true) {
                addressController.text = result.address!;
              } else {
                addressController.text =
                    '${result.latitude.toStringAsFixed(5)}, ${result.longitude.toStringAsFixed(5)}';
              }
            }
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F7FF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF005BEA).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_location_alt_outlined,
                  color: Color(0xFF005BEA),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  '+ Location (${strings.chooseOnMap})',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: const Color(0xFF005BEA),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
