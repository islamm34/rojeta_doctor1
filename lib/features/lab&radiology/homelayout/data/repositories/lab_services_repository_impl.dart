import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../../domain/repositories/lab_services_repository.dart';
import '../datasources/lab_services_remote_data_source.dart';
import '../models/create_lab_service_model.dart';
import '../models/lab_services_response_model.dart';

class LabServicesRepositoryImpl implements LabServicesRepository {
  final LabServicesRemoteDataSource remoteDataSource;

  LabServicesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LabServicesResponseModel>> getServices({
    UserType? userType,
  }) async {
    try {
      final response = await remoteDataSource.getServices(userType: userType);
      return Right(response);
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

  @override
  Future<Either<Failure, void>> addService(
    CreateLabServiceModel service, {
    UserType? userType,
  }) async {
    try {
      await remoteDataSource.addService(service, userType: userType);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to add service'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteService(
    String id, {
    UserType? userType,
  }) async {
    try {
      await remoteDataSource.deleteService(id, userType: userType);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to delete service'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
