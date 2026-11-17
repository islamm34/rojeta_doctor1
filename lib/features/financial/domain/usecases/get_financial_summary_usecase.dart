import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/financial_summary_model.dart';
import '../repositories/financial_repository.dart';

class GetFinancialSummaryUseCase {
  final FinancialRepository repository;

  GetFinancialSummaryUseCase(this.repository);

  Future<Either<Failure, FinancialSummaryModel>> call({
    String? period,
    String? startDate,
    String? endDate,
  }) async {
    return await repository.getFinancialSummary(
      period: period,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
