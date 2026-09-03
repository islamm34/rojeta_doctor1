import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class ClinicLabeledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final int maxLines;
  final TextEditingController? controller;

  const ClinicLabeledTextField({
    super.key,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodyMedium),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
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
