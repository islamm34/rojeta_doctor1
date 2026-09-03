import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class ClinicServicePricingRow extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;
  final String defaultPrice;

  const ClinicServicePricingRow({
    super.key,
    required this.label,
    required this.isEnabled,
    required this.onChanged,
    this.defaultPrice = '300',
  });

  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            enabled: isEnabled,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: defaultPrice,
              suffixText: strings.egp,
              filled: true,
              fillColor: isEnabled
                  ? theme.colorScheme.surface
                  : Colors.grey.shade100,
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
