import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import 'clinic_service_pricing_row.dart';

class AdditionalServicesPricingSection extends StatefulWidget {
  const AdditionalServicesPricingSection({super.key});

  @override
  State<AdditionalServicesPricingSection> createState() =>
      _AdditionalServicesPricingSectionState();
}

class _AdditionalServicesPricingSectionState
    extends State<AdditionalServicesPricingSection> {
  bool _homeVisitEnabled = false;
  bool _videoCallEnabled = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.additionalServicesAndPricing,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          strings.additionalServicesDesc,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        ClinicServicePricingRow(
          label: strings.homeVisit,
          isEnabled: _homeVisitEnabled,
          onChanged: (val) => setState(() => _homeVisitEnabled = val),
        ),
        const SizedBox(height: 16),
        ClinicServicePricingRow(
          label: strings.videoCall,
          isEnabled: _videoCallEnabled,
          onChanged: (val) => setState(() => _videoCallEnabled = val),
        ),
      ],
    );
  }
}
