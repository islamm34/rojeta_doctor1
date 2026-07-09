import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

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
        Text(strings.workingHours, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ...days.map((day) => _buildDayRow(context, day['key']!, day['label']!)),
      ],
    );
  }

  Widget _buildDayRow(BuildContext context, String key, String label) {
    final theme = context.theme;
    final strings = context.strings;
    final isActive = _activeDays[key] ?? false;

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
                  onChanged: (val) {
                    setState(() {
                      _activeDays[key] = val ?? false;
                    });
                  },
                ),
                Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: isActive
                ? Row(
                    children: [
                      Expanded(
                        child: _buildTimePicker(context, '09:00 AM'),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('-'),
                      ),
                      Expanded(
                        child: _buildTimePicker(context, '10:00 PM'),
                      ),
                    ],
                  )
                : Text(strings.closed, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context, String initialTime) {
    final theme = context.theme;
    return InkWell(
      onTap: () {},
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
            Text(initialTime, style: theme.textTheme.bodyMedium),
            const Icon(Icons.arrow_drop_down, size: 20),
          ],
        ),
      ),
    );
  }
}
