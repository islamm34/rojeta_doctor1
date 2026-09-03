import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'marketing_header_description.dart';
import 'marketing_header_feature_row.dart';

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
                const MarketingHeaderDescription(),
                const SizedBox(height: 12),
                MarketingHeaderFeatureRow(
                  text: context.strings.profContentCreation,
                ),
                const SizedBox(height: 6),
                MarketingHeaderFeatureRow(
                  text: context.strings.targetedAudienceReach,
                ),
                const SizedBox(height: 6),
                MarketingHeaderFeatureRow(
                  text: context.strings.perfTrackingAnalytics,
                ),
                const SizedBox(height: 6),
                MarketingHeaderFeatureRow(
                  text: context.strings.brandBuildingCredibility,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
