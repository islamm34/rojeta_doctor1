import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class AdditionalServicesPricingSection extends StatefulWidget {
  const AdditionalServicesPricingSection({super.key});

  @override
  State<AdditionalServicesPricingSection> createState() => _AdditionalServicesPricingSectionState();
}

class _AdditionalServicesPricingSectionState extends State<AdditionalServicesPricingSection> {
  bool _homeVisitEnabled = false;
  bool _videoCallEnabled = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(strings.additionalServicesAndPricing, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(strings.additionalServicesDesc, style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
        const SizedBox(height: 16),
        _buildPricingRow(
          context,
          label: strings.homeVisit,
          isEnabled: _homeVisitEnabled,
          onChanged: (val) => setState(() => _homeVisitEnabled = val),
        ),
        const SizedBox(height: 16),
        _buildPricingRow(
          context,
          label: strings.videoCall,
          isEnabled: _videoCallEnabled,
          onChanged: (val) => setState(() => _videoCallEnabled = val),
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
