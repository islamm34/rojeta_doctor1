import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import 'clinic_day_row.dart';

class WorkingHoursSection extends StatefulWidget {
  const WorkingHoursSection({super.key});

  @override
  State<WorkingHoursSection> createState() => _WorkingHoursSectionState();
}

class _WorkingHoursSectionState extends State<WorkingHoursSection> {
  final Map<String, bool> _activeDays = {};

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    final days = [
      {'key': 'sat', 'label': strings.saturday},
      {'key': 'sun', 'label': strings.sunday},
      {'key': 'mon', 'label': strings.monday},
      {'key': 'tue', 'label': strings.tuesday},
      {'key': 'wed', 'label': strings.wednesday},
      {'key': 'thu', 'label': strings.thursday},
      {'key': 'fri', 'label': strings.friday},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.workingHours,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...days.map(
          (day) => ClinicDayRow(
            label: day['label']!,
            isActive: _activeDays[day['key']!] ?? false,
            onChanged: (val) {
              setState(() {
                _activeDays[day['key']!] = val ?? false;
              });
            },
          ),
        ),
      ],
    );
  }
}
