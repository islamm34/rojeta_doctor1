import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/app_colors.dart';
import '../../../data/models/marketing_package_model.dart';
import 'subscription_confirmation_dialog.dart';

class PackageCard extends StatelessWidget {
  final MarketingPackageModel package;
  final bool isYearly;
  final bool isCurrentPlan;
  final void Function(String packageId, String billingCycle)? onSubscribe;

  const PackageCard({
    super.key,
    required this.package,
    required this.isYearly,
    this.isCurrentPlan = false,
    this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    final price = isYearly ? package.yearlyPrice : package.monthlyPrice;
    final priceString = '$price ${context.strings.egpPerYear}';

    String name = '';
    switch (package.nameKey) {
      case 'basic':
        name = context.strings.basic;
        break;
      case 'professional':
        name = context.strings.professional;
        break;
      case 'premium':
        name = context.strings.premium;
        break;
      default:
        name = package.nameKey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: package.isMostPopular
            ? Border.all(color: AppColors.offerGradientStart, width: 2)
            : Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (package.isMostPopular)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: const BoxDecoration(
                color: AppColors.offerGradientStart,
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
              ),
              child: Text(
                context.strings.mostPopular,
                textAlign: TextAlign.center,
                style: context.textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${package.postsPerMonth} ${context.strings.postsPerMonth}',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: AppColors.offerGradientStart,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  priceString,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: package.platforms.map((platform) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        platform,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: Colors.blue.shade700,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                ...package.features.map((featureKey) {
                  String featureName = '';
                  switch (featureKey) {
                    case 'designQuality':
                      featureName = context.strings.designQuality;
                      break;
                    case 'analytics':
                      featureName = context.strings.analytics;
                      break;
                    case 'priority':
                      featureName = context.strings.priority;
                      break;
                    case 'support':
                      featureName = context.strings.support;
                      break;
                    default:
                      featureName = featureKey;
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.check, color: Colors.green, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            featureName,
                            style: context.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isCurrentPlan
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  SubscriptionConfirmationDialog(
                                    package: package,
                                    isYearly: isYearly,
                                    onConfirm: () {
                                      onSubscribe?.call(
                                        package.id,
                                        isYearly ? 'yearly' : 'monthly',
                                      );
                                    },
                                  ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isCurrentPlan
                          ? Colors.grey.shade300
                          : (package.isMostPopular
                                ? AppColors.offerGradientStart
                                : AppColors.primary),
                      foregroundColor: isCurrentPlan
                          ? Colors.grey.shade700
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isCurrentPlan
                          ? context.strings.currentPlan
                          : context.strings.subscribeNow,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
