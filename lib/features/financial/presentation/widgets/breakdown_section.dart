import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import '../../data/models/financial_summary_model.dart';
import 'breakdown_row_item.dart';

class BreakdownSection extends StatelessWidget {
  final FinancialSummaryModel summary;

  const BreakdownSection({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormatter = NumberFormat.currency(
      locale: 'ar_EG',
      symbol: context.strings.egp,
      decimalDigits: 0,
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.strings.financialBreakdown,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          BreakdownRowItem(
            title: context.strings.totalEarned,
            value: currencyFormatter.format(summary.totalEarnings),
            icon: Icons.account_balance_wallet_outlined,
            iconColor: Colors.blue,
            iconBgColor: Colors.blue.withValues(alpha: 0.1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Divider(color: Colors.grey.shade100),
          ),
          BreakdownRowItem(
            title: context.strings.platformFees,
            value: '- ${currencyFormatter.format(summary.platformFees)}',
            icon: Icons.percent_outlined,
            iconColor: Colors.orange,
            iconBgColor: Colors.orange.withValues(alpha: 0.1),
            valueColor: Colors.red.shade400,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Divider(color: Colors.grey.shade100),
          ),
          BreakdownRowItem(
            title: context.strings.netRevenue,
            value: currencyFormatter.format(summary.netIncome),
            icon: Icons.check_circle_outline,
            iconColor: Colors.green,
            iconBgColor: Colors.green.withValues(alpha: 0.1),
            valueColor: Colors.green.shade600,
            isBold: true,
          ),
        ],
      ),
    );
  }
}
