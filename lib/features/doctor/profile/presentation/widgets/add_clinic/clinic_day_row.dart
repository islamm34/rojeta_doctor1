import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import 'clinic_time_picker_box.dart';

class ClinicDayRow extends StatelessWidget {
  final String label;
  final bool isActive;
  final ValueChanged<bool?> onChanged;
  final String startTime;
  final String endTime;
  final VoidCallback? onStartTimeTap;
  final VoidCallback? onEndTimeTap;

  const ClinicDayRow({
    super.key,
    required this.label,
    required this.isActive,
    required this.onChanged,
    this.startTime = '09:00 AM',
    this.endTime = '10:00 PM',
    this.onStartTimeTap,
    this.onEndTimeTap,
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
                  activeColor: theme.colorScheme.primary,
                ),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: isActive
                ? Row(
                    children: [
                      Expanded(
                        child: ClinicTimePickerBox(
                          initialTime: startTime,
                          onTap: onStartTimeTap,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('-'),
                      ),
                      Expanded(
                        child: ClinicTimePickerBox(
                          initialTime: endTime,
                          onTap: onEndTimeTap,
                        ),
                      ),
                    ],
                  )
                : Text(
                    strings.closed,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
