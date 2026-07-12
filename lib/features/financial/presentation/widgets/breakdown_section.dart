import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../data/models/financial_summary_model.dart';
import 'package:intl/intl.dart';

class BreakdownSection extends StatelessWidget {
  final FinancialSummaryModel summary;

  const BreakdownSection({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.strings;
    final formatter = NumberFormat('#,###');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.breakdown,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                _buildBreakdownRow(
                  context: context,
                  title: strings.totalIncome,
                  value: '${formatter.format(summary.totalIncome)} EGP',
                  icon: Icons.trending_up,
                  iconColor: Colors.blue,
                  iconBgColor: Colors.blue.shade50,
                  valueColor: theme.textTheme.titleMedium?.color,
                ),
                Divider(height: 24.h, color: Colors.grey.shade100),
                _buildBreakdownRow(
                  context: context,
                  title: '${strings.platformCommission} (10%)',
                  value: '-${formatter.format(summary.commission)} EGP',
                  icon: Icons.description_outlined,
                  iconColor: Colors.orange,
                  iconBgColor: Colors.orange.shade50,
                  valueColor: Colors.red,
                ),
                Divider(height: 24.h, color: Colors.grey.shade100),
                _buildBreakdownRow(
                  context: context,
                  title: strings.yourNetIncome,
                  value: '${formatter.format(summary.netIncome)} EGP',
                  icon: Icons.attach_money,
                  iconColor: const Color(0xFF00B050),
                  iconBgColor: const Color(0xFF00B050).withValues(alpha: 0.1),
                  valueColor: const Color(0xFF00B050),
                  isBold: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    Color? valueColor,
    bool isBold = false,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade700,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            color: valueColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
