import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class MarketingHeaderFeatureRow extends StatelessWidget {
  final String text;

  const MarketingHeaderFeatureRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 14),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF4B5563),
            ),
          ),
        ),
      ],
    );
  }
}
