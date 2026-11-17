import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/transaction_model.dart';
import '../repositories/financial_repository.dart';

class GetTransactionsUseCase {
  final FinancialRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<Either<Failure, List<TransactionModel>>> call({
    String? period,
    String? startDate,
    String? endDate,
  }) async {
    return await repository.getTransactions(
      period: period,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
