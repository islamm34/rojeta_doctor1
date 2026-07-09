import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/features/doctor/profile/data/models/analytics_model.dart';

class AnalyticsAppointmentsTypeSection extends StatelessWidget {
  final List<AppointmentTypeStatModel> appointmentTypes;

  const AnalyticsAppointmentsTypeSection({
    super.key,
    required this.appointmentTypes,
  });

  static const List<Color> _typeColors = [
    Color(0xFF1B9ED9),
    Color(0xFF9C3DFF),
    Color(0xFF00B050),
    Color(0xFFFC5600),
  ];

  String _labelFor(BuildContext context, String typeKey) {
    switch (typeKey) {
      case 'clinicVisit':
        return context.strings.clinicVisit;
      case 'homeVisit':
        return context.strings.homeVisit;
      case 'videoCall':
        return context.strings.videoCall;
      case 'followUp':
        return context.strings.followUp;
      default:
        return typeKey;
    }
  }

  String _formatRevenue(double revenue) {
    return revenue.toStringAsFixed(0).replaceAllMapped(
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
              const Icon(Icons.bar_chart_rounded,
                  size: 18, color: Color(0xFF1B9ED9)),
              const SizedBox(width: 6),
              Text(
                context.strings.appointmentsByType,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(appointmentTypes.length, (i) {
            final item = appointmentTypes[i];
            final color = _typeColors[i % _typeColors.length];
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _AppointmentTypeRow(
                label: _labelFor(context, item.typeKey),
                count: item.count,
                percentage: item.percentage,
                revenue: _formatRevenue(item.revenue),
                color: color,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _AppointmentTypeRow extends StatelessWidget {
  final String label;
  final int count;
  final int percentage;
  final String revenue;
  final Color color;

  const _AppointmentTypeRow({
    required this.label,
    required this.count,
    required this.percentage,
    required this.revenue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              '$count ($percentage%)',
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '$revenue EGP',
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: color.withOpacity(0.12),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 5,
          ),
        ),
      ],
    );
  }
}
