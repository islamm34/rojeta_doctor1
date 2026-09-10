import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import 'clinic_service_pricing_row.dart';

class ClinicServicesPricingSection extends StatefulWidget {
  final TextEditingController visitPriceController;
  final TextEditingController followUpPriceController;
  final bool initialVisitEnabled;
  final bool initialFollowUpEnabled;
  final ValueChanged<bool>? onVisitEnabledChanged;
  final ValueChanged<bool>? onFollowUpEnabledChanged;

  const ClinicServicesPricingSection({
    super.key,
    required this.visitPriceController,
    required this.followUpPriceController,
    this.initialVisitEnabled = true,
    this.initialFollowUpEnabled = true,
    this.onVisitEnabledChanged,
    this.onFollowUpEnabledChanged,
  });

  @override
  State<ClinicServicesPricingSection> createState() =>
      _ClinicServicesPricingSectionState();
}

class _ClinicServicesPricingSectionState
    extends State<ClinicServicesPricingSection> {
  late bool _clinicVisitEnabled;
  late bool _followUpEnabled;

  @override
  void initState() {
    super.initState();
    _clinicVisitEnabled = widget.initialVisitEnabled;
    _followUpEnabled = widget.initialFollowUpEnabled;
  }

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
          controller: widget.visitPriceController,
          onChanged: (val) {
            setState(() => _clinicVisitEnabled = val);
            widget.onVisitEnabledChanged?.call(val);
          },
        ),
        const SizedBox(height: 16),
        ClinicServicePricingRow(
          label: strings.followUp,
          isEnabled: _followUpEnabled,
          controller: widget.followUpPriceController,
          onChanged: (val) {
            setState(() => _followUpEnabled = val);
            widget.onFollowUpEnabledChanged?.call(val);
          },
        ),
      ],
    );
  }
}
