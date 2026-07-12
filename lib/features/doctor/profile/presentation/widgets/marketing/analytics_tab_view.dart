import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/app_colors.dart';
import 'package:rojeta_doctor/features/doctor/profile/data/mocks/analytics_mock_data.dart';
import 'analytics_stats_cards_section.dart';
import 'analytics_appointments_type_section.dart';
import 'analytics_weekly_performance_section.dart';
import 'analytics_performance_summary_section.dart';

class AnalyticsTabView extends StatelessWidget {
  const AnalyticsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final analytics = AnalyticsMockData.analytics;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _AnalyticsHeader(monthLabel: analytics.monthLabel),
        const SizedBox(height: 16),
        AnalyticsStatsCardsSection(analytics: analytics),
        const SizedBox(height: 16),
        AnalyticsAppointmentsTypeSection(
          appointmentTypes: analytics.appointmentTypes,
        ),
        const SizedBox(height: 16),
        AnalyticsWeeklyPerformanceSection(weeklyStats: analytics.weeklyStats),
        const SizedBox(height: 16),
        AnalyticsPerformanceSummarySection(analytics: analytics),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _AnalyticsHeader extends StatelessWidget {
  final String monthLabel;

  const _AnalyticsHeader({required this.monthLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.strings.monthlyStatistics,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  monthLabel,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.bar_chart_rounded,
              size: 20,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
