import 'package:flutter/material.dart';
import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import 'settings_marketing_list_item.dart';

class SettingsMarketingBannerCard extends StatelessWidget {
  const SettingsMarketingBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const pinkColor = Color(0xFFD61A8A);
    const lightPinkColor = Color(0xFFFDF0F6);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightPinkColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: pinkColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: pinkColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.campaign,
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
                      context.strings.marketingAndPromotion,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      context.strings.marketingSubtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            context.strings.marketingDesc,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 16),
          SettingsMarketingListItem(
            icon: Icons.share,
            text: context.strings.marketingPoint1,
            iconColor: pinkColor,
          ),
          SettingsMarketingListItem(
            icon: Icons.campaign_outlined,
            text: context.strings.marketingPoint2,
            iconColor: pinkColor,
          ),
          SettingsMarketingListItem(
            icon: Icons.analytics_outlined,
            text: context.strings.marketingPoint3,
            iconColor: pinkColor,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                context.pushNamed(AppRoutes.marketingPackages);
              },
              icon: const Icon(Icons.campaign, color: Colors.white),
              label: Text(
                context.strings.viewMarketingPackages,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: pinkColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
