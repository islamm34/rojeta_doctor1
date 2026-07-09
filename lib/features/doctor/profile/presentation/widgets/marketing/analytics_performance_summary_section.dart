import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/features/doctor/profile/data/models/analytics_model.dart';

class AnalyticsPerformanceSummarySection extends StatelessWidget {
  final AnalyticsModel analytics;

  const AnalyticsPerformanceSummarySection({
    super.key,
    required this.analytics,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                size: 18,
                color: Color(0xFF9C3DFF),
              ),
              const SizedBox(width: 6),
              Text(
                context.strings.performanceSummary,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SummaryRow(
            label: context.strings.patientGrowth,
            value: '+${analytics.patientGrowthPercent.toStringAsFixed(1)}%',
            valueColor: const Color(0xFF00B050),
            icon: Icons.trending_up_rounded,
          ),
          const Divider(height: 24),
          _SummaryRow(
            label: context.strings.revenueGrowth,
            value: '+${analytics.revenueGrowthPercent.toStringAsFixed(1)}%',
            valueColor: const Color(0xFF00B050),
            icon: Icons.trending_up_rounded,
          ),
          const Divider(height: 24),
          _SummaryRow(
            label: context.strings.successRate,
            value: '${analytics.successRate.toStringAsFixed(1)}%',
            valueColor: const Color(0xFF1B9ED9),
            icon: null,
          ),
          const Divider(height: 24),
          _SummaryRow(
            label: context.strings.avgRevenuePerPatient,
            value: '${analytics.avgPerPatient.toStringAsFixed(0)} EGP',
            valueColor: const Color(0xFF00B050),
            icon: null,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final IconData? icon;

  const _SummaryRow({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.black87,
            ),
          ),
        ),
        if (icon != null) ...[
          Icon(icon, size: 16, color: valueColor),
          const SizedBox(width: 4),
        ],
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
