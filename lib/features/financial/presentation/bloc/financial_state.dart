import '../../data/models/financial_summary_model.dart';
import '../../data/models/transaction_model.dart';

enum FinancialStatus { initial, loading, success, failure }

class FinancialState {
  final FinancialStatus status;
  final String? errorMessage;
  final FinancialSummaryModel? summary;
  final List<TransactionModel> transactions;

  const FinancialState({
    this.status = FinancialStatus.initial,
    this.errorMessage,
    this.summary,
    this.transactions = const [],
  });

  FinancialState copyWith({
    FinancialStatus? status,
    String? errorMessage,
    FinancialSummaryModel? summary,
    List<TransactionModel>? transactions,
  }) {
    return FinancialState(
      status: status ?? this.status,
      errorMessage: errorMessage, // We don't ?? here so we can clear it
      summary: summary ?? this.summary,
      transactions: transactions ?? this.transactions,
    );
  }
}
