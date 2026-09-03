import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import 'clinic_time_picker_box.dart';

class ClinicDayRow extends StatelessWidget {
  final String label;
  final bool isActive;
  final ValueChanged<bool?> onChanged;

  const ClinicDayRow({
    super.key,
    required this.label,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Row(
              children: [
                Checkbox(
                  value: isActive,
                  onChanged: onChanged,
                ),
                Expanded(
                  child: Text(label, style: theme.textTheme.bodyMedium),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: isActive
                ? const Row(
                    children: [
                      Expanded(
                        child: ClinicTimePickerBox(initialTime: '09:00 AM'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('-'),
                      ),
                      Expanded(
                        child: ClinicTimePickerBox(initialTime: '10:00 PM'),
                      ),
                    ],
                  )
                : Text(
                    strings.closed,
                    style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
          ),
        ],
      ),
    );
  }
}
