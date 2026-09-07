import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import 'clinic_day_row.dart';

class WorkingHoursSection extends StatefulWidget {
  final Map<String, dynamic>? initialWorkingHours;
  final ValueChanged<Map<String, dynamic>>? onWorkingHoursChanged;

  const WorkingHoursSection({
    super.key,
    this.initialWorkingHours,
    this.onWorkingHoursChanged,
  });

  @override
  State<WorkingHoursSection> createState() => _WorkingHoursSectionState();
}

class _WorkingHoursSectionState extends State<WorkingHoursSection> {
  final Map<String, bool> _activeDays = {
    'sat': true,
    'sun': true,
    'mon': true,
    'tue': true,
    'wed': true,
    'thu': true,
    'fri': false,
  };
  final Map<String, String> _startTimes = {};
  final Map<String, String> _endTimes = {};

  @override
  void initState() {
    super.initState();
    if (widget.initialWorkingHours != null && widget.initialWorkingHours!.isNotEmpty) {
      widget.initialWorkingHours!.forEach((key, val) {
        if (val is Map) {
          _activeDays[key] = val['isOpen'] == true || val['is_open'] == true;
          if (val['start'] != null) _startTimes[key] = val['start'].toString();
          if (val['end'] != null) _endTimes[key] = val['end'].toString();
        } else if (val is bool) {
          _activeDays[key] = val;
        }
      });
    }
  }

  void _notifyChanges() {
    final result = <String, dynamic>{};
    for (final key in _activeDays.keys) {
      result[key] = {
        'isOpen': _activeDays[key] ?? false,
        'start': _startTimes[key] ?? '09:00 AM',
        'end': _endTimes[key] ?? '10:00 PM',
      };
    }
    widget.onWorkingHoursChanged?.call(result);
  }

  Future<void> _selectTime(String dayKey, bool isStart) async {
    final initialStr = isStart
        ? (_startTimes[dayKey] ?? '09:00 AM')
        : (_endTimes[dayKey] ?? '10:00 PM');

    TimeOfDay initialTime = isStart
        ? const TimeOfDay(hour: 9, minute: 0)
        : const TimeOfDay(hour: 22, minute: 0);

    try {
      final clean = initialStr.trim();
      final spaceIndex = clean.indexOf(' ');
      if (spaceIndex != -1) {
        final timePart = clean.substring(0, spaceIndex);
        final period = clean.substring(spaceIndex + 1).toUpperCase();
        final colonIndex = timePart.indexOf(':');
        var hour = int.parse(timePart.substring(0, colonIndex));
        final minute = int.parse(timePart.substring(colonIndex + 1));
        if (period == 'PM' && hour < 12) hour += 12;
        if (period == 'AM' && hour == 12) hour = 0;
        initialTime = TimeOfDay(hour: hour, minute: minute);
      }
    } catch (_) {}

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null && mounted) {
      final formatted = picked.format(context);
      setState(() {
        if (isStart) {
          _startTimes[dayKey] = formatted;
        } else {
          _endTimes[dayKey] = formatted;
        }
      });
      _notifyChanges();
    }
  }

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
          (day) {
            final key = day['key']!;
            final isActive = _activeDays[key] ?? false;
            final startTime = _startTimes[key] ?? '09:00 AM';
            final endTime = _endTimes[key] ?? '10:00 PM';

            return ClinicDayRow(
              label: day['label']!,
              isActive: isActive,
              startTime: startTime,
              endTime: endTime,
              onStartTimeTap: () => _selectTime(key, true),
              onEndTimeTap: () => _selectTime(key, false),
              onChanged: (val) {
                setState(() {
                  _activeDays[key] = val ?? false;
                });
                _notifyChanges();
              },
            );
          },
        ),
      ],
    );
  }
}
