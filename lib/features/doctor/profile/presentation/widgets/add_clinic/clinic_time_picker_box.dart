import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/extensions/time_extensions.dart';

class ClinicTimePickerBox extends StatelessWidget {
  final String initialTime;
  final VoidCallback? onTap;

  const ClinicTimePickerBox({super.key, required this.initialTime, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                initialTime.formatTo12Hour(context),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 20),
          ],
        ),
      ),
    );
  }
}
