import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class ClinicServicesPricingSection extends StatefulWidget {
  const ClinicServicesPricingSection({super.key});

  @override
  State<ClinicServicesPricingSection> createState() => _ClinicServicesPricingSectionState();
}

class _ClinicServicesPricingSectionState extends State<ClinicServicesPricingSection> {
  bool _clinicVisitEnabled = true;
  bool _followUpEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(strings.servicesAndPricingAtClinic, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildPricingRow(
          context,
          label: strings.clinicVisit,
          isEnabled: _clinicVisitEnabled,
          onChanged: (val) => setState(() => _clinicVisitEnabled = val),
        ),
        const SizedBox(height: 16),
        _buildPricingRow(
          context,
          label: strings.followUp,
          isEnabled: _followUpEnabled,
          onChanged: (val) => setState(() => _followUpEnabled = val),
        ),
      ],
    );
  }

  Widget _buildPricingRow(
    BuildContext context, {
    required String label,
    required bool isEnabled,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = context.theme;
    final strings = context.strings;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Switch(
                value: isEnabled,
                onChanged: onChanged,
                activeColor: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(label, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            enabled: isEnabled,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '300',
              suffixText: strings.egp,
              filled: true,
              fillColor: isEnabled ? theme.colorScheme.surface : Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
