import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/app_colors.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';

import '../../../data/models/marketing_package_model.dart';
import 'package_card.dart';

class PackagesTabView extends StatefulWidget {
  final List<MarketingPackageModel> packages;
  final ActivePlanModel? activePlan;
  final void Function(String packageId, String billingCycle)? onSubscribe;

  const PackagesTabView({
    super.key,
    required this.packages,
    this.activePlan,
    this.onSubscribe,
  });

  @override
  State<PackagesTabView> createState() => _PackagesTabViewState();
}

class _PackagesTabViewState extends State<PackagesTabView> {
  bool isYearly = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.strings.monthly,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: !isYearly ? FontWeight.bold : FontWeight.normal,
                color: !isYearly ? Colors.black87 : Colors.grey,
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: isYearly,
              onChanged: (val) {
                setState(() {
                  isYearly = val;
                });
              },
              activeThumbColor: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Text(
              context.strings.yearly,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: isYearly ? FontWeight.bold : FontWeight.normal,
                color: isYearly ? Colors.black87 : Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.offerGradientStart.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              context.strings.save17,
              style: context.textTheme.labelMedium?.copyWith(
                color: AppColors.offerGradientStart,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        ...widget.packages.map((pkg) {
          final isCurrentPlan = pkg.id == widget.activePlan?.packageId;
          return PackageCard(
            package: pkg,
            isYearly: isYearly,
            isCurrentPlan: isCurrentPlan,
            onSubscribe: widget.onSubscribe,
          );
        }),
      ],
    );
  }
}
