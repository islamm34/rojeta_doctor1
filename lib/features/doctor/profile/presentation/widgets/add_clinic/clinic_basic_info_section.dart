import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class ClinicBasicInfoSection extends StatelessWidget {
  const ClinicBasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(strings.basicInformation, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTextField(context, label: strings.clinicName, hint: strings.clinicNameHint),
        const SizedBox(height: 16),
        _buildTextField(context, label: strings.clinicPhone, hint: strings.clinicPhoneHint, keyboardType: TextInputType.phone),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTextField(context, label: strings.governorate, hint: '')),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField(context, label: strings.city, hint: '')),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(context, label: strings.fullAddress, hint: strings.fullAddressHint, maxLines: 2),
      ],
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodyMedium),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            filled: true,
            fillColor: theme.colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }
}
