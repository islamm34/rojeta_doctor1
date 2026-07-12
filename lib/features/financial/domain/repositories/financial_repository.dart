import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/financial_summary_model.dart';
import '../../data/models/transaction_model.dart';

abstract class FinancialRepository {
  Future<Either<Failure, FinancialSummaryModel>> getFinancialSummary();
  Future<Either<Failure, List<TransactionModel>>> getTransactions();
}
