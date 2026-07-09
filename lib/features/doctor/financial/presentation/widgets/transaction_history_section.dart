import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../../core/utils/screen_util_like.dart';
import '../../data/models/transaction_model.dart';
import 'transaction_item_card.dart';

class TransactionHistorySection extends StatelessWidget {
  final List<TransactionModel> transactions;

  const TransactionHistorySection({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.strings;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                strings.transactionHistory,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  // Export functionality
                },
                icon: const Icon(Icons.download_outlined, size: 18),
                label: Text(strings.export),
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return TransactionItemCard(transaction: transactions[index]);
            },
          ),
        ],
      ),
    );
  }
}
