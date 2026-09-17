import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/extensions/time_extensions.dart';
import '../../../../core/utils/screen_util_like.dart';
import '../../data/models/transaction_model.dart';
import 'transaction_amount_row.dart';

class TransactionItemCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItemCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.strings;
    final formatter = NumberFormat('#,##0.00');

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${strings.transactionId}: ${transaction.id}',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  strings.completed,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF2E7D32),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            _formatDateTime(context, transaction),
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              CircleAvatar(
                radius: 12.r,
                backgroundColor: Colors.blue.withValues(alpha: 0.1),
                child: Icon(Icons.person, size: 14.r, color: Colors.blue),
              ),
              SizedBox(width: 8.w),
              Text(
                transaction.patientName,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  transaction.serviceType,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(color: Colors.grey.shade100),
          ),
          TransactionAmountRow(
            title: strings.grossAmount,
            value: '${formatter.format(transaction.grossAmount)} EGP',
          ),
          SizedBox(height: 6.h),
          TransactionAmountRow(
            title: strings.feesDeducted,
            value: '-${formatter.format(transaction.feesDeducted)} EGP',
            valueColor: Colors.red.shade400,
          ),
          SizedBox(height: 6.h),
          TransactionAmountRow(
            title: strings.yourEarning,
            value: '${formatter.format(transaction.yourEarning)} EGP',
            valueColor: const Color(0xFF00B050),
            isBold: true,
          ),
        ],
      ),
    );
  }

  String _formatDateTime(BuildContext context, TransactionModel transaction) {
    return TimeFormatter.formatDateTime(
      transaction.date,
      transaction.time,
      context: context,
    );
  }
}
