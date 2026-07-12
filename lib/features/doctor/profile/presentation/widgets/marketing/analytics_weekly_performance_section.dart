import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/app_colors.dart';
import 'package:rojeta_doctor/features/doctor/profile/data/models/analytics_model.dart';

class AnalyticsWeeklyPerformanceSection extends StatelessWidget {
  final List<WeeklyStatModel> weeklyStats;

  const AnalyticsWeeklyPerformanceSection({
    super.key,
    required this.weeklyStats,
  });

  String _formatRevenue(double revenue) {
    return revenue
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
  }

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
                Icons.show_chart_rounded,
                size: 18,
                color: Color(0xFF00B050),
              ),
              const SizedBox(width: 6),
              Text(
                context.strings.weeklyPerformance,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(weeklyStats.length, (i) {
            final week = weeklyStats[i];
            return Padding(
              padding: EdgeInsets.only(
                bottom: i < weeklyStats.length - 1 ? 16 : 0,
              ),
              child: _WeekRow(
                weekLabel: week.weekLabel,
                patients: week.patients,
                revenue: _formatRevenue(week.revenue),
                patientsPercent: week.patientsPercent,
                revenuePercent: week.revenuePercent,
                patientsLabel: context.strings.patientsLabel,
                revenueLabel: context.strings.revenueLabel,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _WeekRow extends StatelessWidget {
  final String weekLabel;
  final int patients;
  final String revenue;
  final double patientsPercent;
  final double revenuePercent;
  final String patientsLabel;
  final String revenueLabel;

  const _WeekRow({
    required this.weekLabel,
    required this.patients,
    required this.revenue,
    required this.patientsPercent,
    required this.revenuePercent,
    required this.patientsLabel,
    required this.revenueLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                weekLabel,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.people_alt_outlined,
              size: 14,
              color: Colors.grey.shade500,
            ),
            const SizedBox(width: 3),
            Text(
              '$patients',
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.attach_money_rounded,
              size: 14,
              color: Colors.grey.shade500,
            ),
            Text(
              revenue,
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          patientsLabel,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
        ),
        const SizedBox(height: 3),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: patientsPercent,
            backgroundColor: const Color(0xFF00B050).withValues(alpha: 0.12),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00B050)),
            minHeight: 5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          revenueLabel,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
        ),
        const SizedBox(height: 3),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: revenuePercent,
            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 5,
          ),
        ),
      ],
    );
  }
}
