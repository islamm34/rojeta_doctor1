import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';

class MarketingHeaderDescription extends StatelessWidget {
  const MarketingHeaderDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final String desc = context.strings.marketingIntroDesc;
    String target = '';

    if (desc.contains('500K+ followers')) {
      target = '500K+ followers';
    } else if (desc.contains('500 ألف متابع')) {
      target = '500 ألف متابع';
    }

    if (target.isEmpty) {
      return Text(
        desc,
        style: context.textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF6B7280),
          height: 1.5,
        ),
      );
    }

    final parts = desc.split(target);
    return RichText(
      text: TextSpan(
        style: context.textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF6B7280),
          height: 1.5,
        ),
        children: [
          TextSpan(text: parts[0]),
          TextSpan(
            text: target,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF4B5563),
            ),
          ),
          if (parts.length > 1) TextSpan(text: parts.sublist(1).join(target)),
        ],
      ),
    );
  }
}
