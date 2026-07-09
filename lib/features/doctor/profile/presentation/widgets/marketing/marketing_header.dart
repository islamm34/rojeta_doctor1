import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/app_colors.dart';

class MarketingHeader extends StatelessWidget {
  const MarketingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFf0e8ff),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC7CDFA), width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF6158FC),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.strings.rujetaSocialMediaMarketing,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF1F2937),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                _buildDescriptionText(context),
                const SizedBox(height: 12),
                _buildFeatureRow(context, context.strings.profContentCreation),
                const SizedBox(height: 6),
                _buildFeatureRow(
                  context,
                  context.strings.targetedAudienceReach,
                ),
                const SizedBox(height: 6),
                _buildFeatureRow(
                  context,
                  context.strings.perfTrackingAnalytics,
                ),
                const SizedBox(height: 6),
                _buildFeatureRow(
                  context,
                  context.strings.brandBuildingCredibility,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionText(BuildContext context) {
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

  Widget _buildFeatureRow(BuildContext context, String text) {
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
