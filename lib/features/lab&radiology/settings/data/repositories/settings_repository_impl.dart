import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/error/exceptions.dart';
import '../../../../../../core/error/failures.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_remote_data_source.dart';
import '../models/general_settings_model.dart';
import '../models/lab_info_model.dart';
import '../models/lab_profile_model.dart';
import '../models/working_hours_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDataSource remoteDataSource;

  SettingsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LabProfileModel>> getLabProfile() async {
    try {
      final profile = await remoteDataSource.getLabProfile();
      return Right(profile);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to load profile'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateLabProfile(LabProfileModel profile) async {
    try {
      await remoteDataSource.updateLabProfile(profile);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to update profile'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GeneralSettingsModel>> getGeneralSettings() async {
    try {
      final settings = await remoteDataSource.getGeneralSettings();
      return Right(settings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to load settings'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateGeneralSettings(
    GeneralSettingsModel settings,
  ) async {
    try {
      await remoteDataSource.updateGeneralSettings(settings);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to update settings'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LabInfoModel>> getLabInfo() async {
    try {
      final info = await remoteDataSource.getLabInfo();
      return Right(info);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to load lab info'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateLabInfo(LabInfoModel info) async {
    try {
      await remoteDataSource.updateLabInfo(info);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to update lab info'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WorkingHoursModel>> getWorkingHours() async {
    try {
      final hours = await remoteDataSource.getWorkingHours();
      return Right(hours);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to load working hours'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateWorkingHours(WorkingHoursModel workingHours) async {
    try {
      await remoteDataSource.updateWorkingHours(workingHours);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to update working hours'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
