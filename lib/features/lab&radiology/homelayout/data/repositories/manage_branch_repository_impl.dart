import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../../domain/repositories/manage_branch_repository.dart';
import '../datasources/manage_branch_remote_data_source.dart';
import '../models/branch_model.dart';

class ManageBranchRepositoryImpl implements ManageBranchRepository {
  final ManageBranchRemoteDataSource remoteDataSource;

  ManageBranchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<BranchModel>>> getBranches({
    UserType? userType,
  }) async {
    try {
      final branches = await remoteDataSource.getBranches(userType: userType);
      return Right(branches);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to load branches'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addBranch(
    BranchModel branch, {
    UserType? userType,
  }) async {
    try {
      await remoteDataSource.addBranch(branch, userType: userType);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to add branch'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBranch(
    String branchId, {
    UserType? userType,
  }) async {
    try {
      await remoteDataSource.deleteBranch(branchId, userType: userType);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to delete branch'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
