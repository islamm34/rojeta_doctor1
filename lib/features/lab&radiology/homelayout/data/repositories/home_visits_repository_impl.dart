import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../../domain/repositories/home_visits_repository.dart';
import '../datasources/home_visits_remote_data_source.dart';
import '../models/home_visit_config_model.dart';

class HomeVisitsRepositoryImpl implements HomeVisitsRepository {
  final HomeVisitsRemoteDataSource remoteDataSource;

  HomeVisitsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, HomeVisitConfigModel>> getHomeVisitsConfig({
    UserType? userType,
  }) async {
    try {
      final config = await remoteDataSource.getHomeVisitsConfig(userType: userType);
      return Right(config);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to load home visits config'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateHomeVisitsConfig(
    HomeVisitConfigModel config, {
    UserType? userType,
  }) async {
    try {
      await remoteDataSource.updateHomeVisitsConfig(config, userType: userType);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to update home visits config'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
