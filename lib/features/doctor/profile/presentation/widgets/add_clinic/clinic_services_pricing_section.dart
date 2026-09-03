import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import 'clinic_service_pricing_row.dart';

class ClinicServicesPricingSection extends StatefulWidget {
  const ClinicServicesPricingSection({super.key});

  @override
  State<ClinicServicesPricingSection> createState() =>
      _ClinicServicesPricingSectionState();
}

class _ClinicServicesPricingSectionState
    extends State<ClinicServicesPricingSection> {
  bool _clinicVisitEnabled = true;
  bool _followUpEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.servicesAndPricingAtClinic,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ClinicServicePricingRow(
          label: strings.clinicVisit,
          isEnabled: _clinicVisitEnabled,
          onChanged: (val) => setState(() => _clinicVisitEnabled = val),
        ),
        const SizedBox(height: 16),
        ClinicServicePricingRow(
          label: strings.followUp,
          isEnabled: _followUpEnabled,
          onChanged: (val) => setState(() => _followUpEnabled = val),
        ),
      ],
    );
  }
}
