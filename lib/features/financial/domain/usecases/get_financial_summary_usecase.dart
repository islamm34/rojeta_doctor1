import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/financial_summary_model.dart';
import '../repositories/financial_repository.dart';

class GetFinancialSummaryUseCase {
  final FinancialRepository repository;

  GetFinancialSummaryUseCase(this.repository);

  Future<Either<Failure, FinancialSummaryModel>> call() async {
    return await repository.getFinancialSummary();
  }
}
