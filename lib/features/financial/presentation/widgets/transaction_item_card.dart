import 'package:flutter/material.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/screen_util_like.dart';
import '../../data/models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionItemCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItemCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.strings;
    final formatter = NumberFormat('#,###');

    final isCompleted = transaction.status.toLowerCase() == 'completed';
    final statusColor = isCompleted ? const Color(0xFF00B050) : Colors.orange;
    final statusBgColor = isCompleted
        ? const Color(0xFF00B050).withValues(alpha: 0.1)
        : Colors.orange.withValues(alpha: 0.1);
    final statusText = isCompleted ? strings.completedStatus : strings.pendingStatus;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.patientName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      transaction.visitType,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  statusText.toUpperCase(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey.shade500),
              SizedBox(width: 6.w),
              Text(
                '${transaction.date} • ${transaction.time}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(height: 1, color: Colors.grey.shade200),
          ),
          _buildAmountRow(
            context,
            title: strings.serviceFee,
            value: '${formatter.format(transaction.serviceFee)} EGP',
          ),
          SizedBox(height: 8.h),
          _buildAmountRow(
            context,
            title: strings.platformCommission,
            value: '-${formatter.format(transaction.platformCommission)} EGP',
            valueColor: Colors.red,
          ),
          SizedBox(height: 8.h),
          _buildAmountRow(
            context,
            title: strings.yourEarning,
            value: '${formatter.format(transaction.yourEarning)} EGP',
            valueColor: const Color(0xFF00B050),
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow(
    BuildContext context, {
    required String title,
    required String value,
    Color? valueColor,
    bool isBold = false,
  }) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isBold ? Colors.black87 : Colors.grey.shade600,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: valueColor ?? Colors.black87,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
