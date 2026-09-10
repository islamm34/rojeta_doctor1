import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import 'clinic_service_pricing_row.dart';

class AdditionalServicesPricingSection extends StatefulWidget {
  final TextEditingController homeVisitPriceController;
  final TextEditingController videoCallPriceController;
  final bool initialHomeVisitEnabled;
  final bool initialVideoCallEnabled;
  final ValueChanged<bool>? onHomeVisitEnabledChanged;
  final ValueChanged<bool>? onVideoCallEnabledChanged;

  const AdditionalServicesPricingSection({
    super.key,
    required this.homeVisitPriceController,
    required this.videoCallPriceController,
    this.initialHomeVisitEnabled = false,
    this.initialVideoCallEnabled = false,
    this.onHomeVisitEnabledChanged,
    this.onVideoCallEnabledChanged,
  });

  @override
  State<AdditionalServicesPricingSection> createState() =>
      _AdditionalServicesPricingSectionState();
}

class _AdditionalServicesPricingSectionState
    extends State<AdditionalServicesPricingSection> {
  late bool _homeVisitEnabled;
  late bool _videoCallEnabled;

  @override
  void initState() {
    super.initState();
    _homeVisitEnabled = widget.initialHomeVisitEnabled;
    _videoCallEnabled = widget.initialVideoCallEnabled;
  }

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
          controller: widget.homeVisitPriceController,
          onChanged: (val) {
            setState(() => _homeVisitEnabled = val);
            widget.onHomeVisitEnabledChanged?.call(val);
          },
        ),
        const SizedBox(height: 16),
        ClinicServicePricingRow(
          label: strings.videoCall,
          isEnabled: _videoCallEnabled,
          controller: widget.videoCallPriceController,
          onChanged: (val) {
            setState(() => _videoCallEnabled = val);
            widget.onVideoCallEnabledChanged?.call(val);
          },
        ),
      ],
    );
  }
}
