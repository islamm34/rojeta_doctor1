import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/app_colors.dart';
import '../../../data/models/marketing_package_model.dart';

class MyPlanTabView extends StatelessWidget {
  final ActivePlanModel? activePlan;
  final List<MarketingPackageModel> packages;

  const MyPlanTabView({
    super.key,
    this.activePlan,
    required this.packages,
  });

  @override
  Widget build(BuildContext context) {
    if (activePlan == null) {
      return Center(
        child: Text(
          context.strings.noDataAvailable,
          style: TextStyle(color: Colors.grey.shade600),
        ),
      );
    }

    final plan = activePlan!;
    final package = packages.firstWhere(
      (p) => p.id == plan.packageId,
      orElse: () => packages.isNotEmpty
          ? packages.first
          : const MarketingPackageModel(
              id: '',
              nameKey: '',
              postsPerMonth: '',
              monthlyPrice: 0,
              yearlyPrice: 0,
              isMostPopular: false,
              platforms: [],
              features: [],
            ),
    );

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

    final double progress = plan.postsUsed / plan.totalPosts;
    final int daysRemaining = plan.endDate
        .difference(DateTime.now())
        .inDays;
    final dateFormat = DateFormat('dd MMM, yyyy');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          context.strings.activePlan,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.offerGradientStart.withValues(
                        alpha: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      context.strings.activePlan,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: AppColors.offerGradientStart,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.strings.postsUsed,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    '${plan.postsUsed} of ${plan.totalPosts}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade200,
                color: AppColors.primary,
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.strings.startDate,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateFormat.format(plan.startDate),
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.strings.endDate,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateFormat.format(plan.endDate),
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Center(
                  child: Text(
                    '${context.strings.daysRemaining}: $daysRemaining',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          context.strings.yourBenefits,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...plan.benefits.map((benefitKey) {
          String benefitText = '';
          switch (benefitKey) {
            case 'benefit1':
              benefitText = context.strings.benefit1;
              break;
            case 'benefit2':
              benefitText = context.strings.benefit2;
              break;
            case 'benefit3':
              benefitText = context.strings.benefit3;
              break;
            case 'benefit4':
              benefitText = context.strings.benefit4;
              break;
            case 'benefit5':
              benefitText = context.strings.benefit5;
              break;
            default:
              benefitText = benefitKey;
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(benefitText, style: context.textTheme.bodyMedium),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 24),
        Text(
          context.strings.previousPlan,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.strings.basic, // Hardcoded for UI demo
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ended 15 Jun, 2024', // Example static date for previous plan
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                child: Text(context.strings.seeDetails),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
