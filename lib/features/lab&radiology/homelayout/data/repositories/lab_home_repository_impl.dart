import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/lab_home_repository.dart';
import '../datasources/lab_home_local_datasource.dart';
import '../models/lab_home_model.dart';

class LabHomeRepositoryImpl implements LabHomeRepository {
  final LabHomeLocalDataSource localDataSource;

  LabHomeRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, LabHomeModel>> getDashboardData() async {
    try {
      final data = await localDataSource.getDashboardData();
      return Right(data);
    } catch (e) {
      return const Left(CacheFailure('Failed to load dashboard data'));
    }
  }
}
