import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../../domain/repositories/lab_home_repository.dart';
import '../datasources/lab_home_remote_data_source.dart';
import '../models/lab_home_model.dart';

class LabHomeRepositoryImpl implements LabHomeRepository {
  final LabHomeRemoteDataSource remoteDataSource;

  LabHomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LabHomeModel>> getDashboardData({
    UserType? userType,
  }) async {
    try {
      final data = await remoteDataSource.getDashboardData(userType: userType);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to connect to server'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
