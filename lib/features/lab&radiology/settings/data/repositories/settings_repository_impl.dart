import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/error/failures.dart';
import '../../domain/entities/lab_profile.dart';
import '../../domain/entities/general_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_remote_data_source.dart';
import '../models/general_settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDataSource remoteDataSource;

  SettingsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LabProfile>> getLabProfile() async {
    try {
      final profile = await remoteDataSource.getLabProfile();
      return Right(profile);
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GeneralSettings>> getGeneralSettings() async {
    try {
      final settings = await remoteDataSource.getGeneralSettings();
      return Right(settings);
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateGeneralSettings(
    GeneralSettings settings,
  ) async {
    try {
      final settingsModel = GeneralSettingsModel(
        emailNotifications: settings.emailNotifications,
        bookingUpdates: settings.bookingUpdates,
        pushNotifications: settings.pushNotifications,
        appointmentReminders: settings.appointmentReminders,
        marketingEmails: settings.marketingEmails,
        language: settings.language,
      );
      await remoteDataSource.updateGeneralSettings(settingsModel);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
