import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class ClinicServicePricingRow extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;
  final String defaultPrice;
  final TextEditingController? controller;
  final ValueChanged<String>? onPriceChanged;

  const ClinicServicePricingRow({
    super.key,
    required this.label,
    required this.isEnabled,
    required this.onChanged,
    this.defaultPrice = '300',
    this.controller,
    this.onPriceChanged,
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
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: isEnabled ? FontWeight.w600 : FontWeight.normal,
                    color: isEnabled
                        ? theme.colorScheme.onSurface
                        : Colors.grey.shade400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: controller,
            enabled: isEnabled,
            keyboardType: TextInputType.number,
            onChanged: onPriceChanged,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isEnabled ? theme.colorScheme.onSurface : Colors.grey.shade400,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: defaultPrice,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.normal,
              ),
              suffixText: strings.egp,
              suffixStyle: theme.textTheme.bodySmall?.copyWith(
                color: isEnabled ? Colors.grey.shade600 : Colors.grey.shade400,
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: isEnabled
                  ? theme.colorScheme.surface
                  : Colors.grey.shade100,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 1.5,
                ),
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
