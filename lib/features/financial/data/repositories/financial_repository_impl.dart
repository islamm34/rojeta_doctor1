import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../models/financial_summary_model.dart';
import '../models/transaction_model.dart';
import '../../domain/repositories/financial_repository.dart';
import '../datasources/financial_remote_data_source.dart';

class FinancialRepositoryImpl implements FinancialRepository {
  final FinancialRemoteDataSource remoteDataSource;

  FinancialRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, FinancialSummaryModel>> getFinancialSummary({
    String? period,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final remoteSummary = await remoteDataSource.getFinancialSummary(
        period: period,
        startDate: startDate,
        endDate: endDate,
      );
      return Right(remoteSummary);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Generic fallback for now
    }
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactions({
    String? period,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final remoteTransactions = await remoteDataSource.getTransactions(
        period: period,
        startDate: startDate,
        endDate: endDate,
      );
      return Right(remoteTransactions);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Generic fallback for now
    }
  }
}
