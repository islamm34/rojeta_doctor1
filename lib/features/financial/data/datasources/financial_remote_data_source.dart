import '../models/financial_summary_model.dart';
import '../models/transaction_model.dart';
import '../mocks/financial_mock_data.dart';

abstract class FinancialRemoteDataSource {
  Future<FinancialSummaryModel> getFinancialSummary();
  Future<List<TransactionModel>> getTransactions();
}

class FinancialRemoteDataSourceImpl implements FinancialRemoteDataSource {
  @override
  Future<FinancialSummaryModel> getFinancialSummary() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return FinancialMockData.summary;
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return FinancialMockData.transactions;
  }
}
