import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/screen_util_like.dart';

class AddServiceTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLines;

  const AddServiceTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: context.colors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: context.colors.primary, width: 2),
        ),
      ),
      validator: (val) {
        if (label != context.strings.preparationsOptional &&
            (val == null || val.isEmpty)) {
          return 'Required field';
        }
        return null;
      },
    );
  }
}
