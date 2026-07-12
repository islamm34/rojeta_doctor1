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
  Future<Either<Failure, FinancialSummaryModel>> getFinancialSummary() async {
    try {
      final remoteSummary = await remoteDataSource.getFinancialSummary();
      return Right(remoteSummary);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Generic fallback for now
    }
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactions() async {
    try {
      final remoteTransactions = await remoteDataSource.getTransactions();
      return Right(remoteTransactions);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Generic fallback for now
    }
  }
}
