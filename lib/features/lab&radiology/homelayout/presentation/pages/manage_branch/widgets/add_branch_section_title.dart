import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';

class AddBranchSectionTitle extends StatelessWidget {
  final String title;

  const AddBranchSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D52),
          ),
    );
  }
}
