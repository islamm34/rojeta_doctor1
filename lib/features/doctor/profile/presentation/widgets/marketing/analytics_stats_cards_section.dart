import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/core/utils/app_colors.dart';
import 'package:rojeta_doctor/features/doctor/profile/data/models/analytics_model.dart';

class AnalyticsStatsCardsSection extends StatelessWidget {
  final AnalyticsModel analytics;

  const AnalyticsStatsCardsSection({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              _StatCard(
                title: context.strings.totalPatients,
                value: analytics.totalPatients.toString(),
                subtitle:
                    '${context.strings.newLabel}: ${analytics.newPatients}   '
                    '${context.strings.returningLabel}: ${analytics.returningPatients}',
                badge: '+${analytics.patientGrowthPercent.toStringAsFixed(1)}%',
                gradient: const LinearGradient(
                  colors: [Color(0xFF1B9ED9), Color(0xFF25C5D9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                icon: Icons.people_alt_outlined,
              ),
              const SizedBox(height: 12),
              _StatCard(
                title: context.strings.netIncomeEgp,
                value: _formatNumber(analytics.netIncome),
                subtitle:
                    '${context.strings.avgPerPatient}: ${analytics.avgPerPatient.toStringAsFixed(0)} EGP',
                gradient: const LinearGradient(
                  colors: [Color(0xFF9C3DFF), Color(0xFFBF6FFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                icon: Icons.trending_up_rounded,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              _StatCard(
                title: context.strings.totalRevenue,
                value: _formatNumber(analytics.totalRevenue),
                subtitle:
                    '${context.strings.expenses}: ${_formatNumber(analytics.expenses)}',
                badge:
                    '+${analytics.revenueGrowthPercent.toStringAsFixed(1)}%',
                gradient: const LinearGradient(
                  colors: [Color(0xFF00B050), Color(0xFF4CD98A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                icon: Icons.attach_money_rounded,
              ),
              const SizedBox(height: 12),
              _StatCard(
                title: context.strings.totalAppointments,
                value: analytics.totalAppointments.toString(),
                subtitle: null,
                completedCount: analytics.completedAppointments,
                cancelledCount: analytics.cancelledAppointments,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFC5600), Color(0xFFFF8C42)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                icon: Icons.calendar_month_outlined,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatNumber(double value) {
    if (value >= 1000) {
      return value.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (m) => '${m[1]},',
          );
    }
    return value.toStringAsFixed(0);
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final String? badge;
  final LinearGradient gradient;
  final IconData icon;
  final int? completedCount;
  final int? cancelledCount;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.gradient,
    required this.icon,
    this.badge,
    this.completedCount,
    this.cancelledCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white70, size: 18),
              const Spacer(),
              if (badge != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    badge!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: context.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(
              subtitle!,
              style: const TextStyle(color: Colors.white70, fontSize: 10),
              maxLines: 2,
            ),
          ],
          if (completedCount != null && cancelledCount != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.check_circle_outline,
                    color: Colors.white70, size: 13),
                const SizedBox(width: 3),
                Text(
                  '$completedCount',
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
                const SizedBox(width: 8),
                Icon(Icons.cancel_outlined, color: Colors.white54, size: 13),
                const SizedBox(width: 3),
                Text(
                  '$cancelledCount',
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
