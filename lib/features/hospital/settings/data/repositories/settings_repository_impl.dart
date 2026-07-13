import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';
import '../models/settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, SettingsModel>> getSettings() async {
    try {
      final localSettings = await localDataSource.getSettings();
      return Right(localSettings);
    } catch (e) {
      return const Left(CacheFailure('Failed to load settings'));
    }
  }

  @override
  Future<Either<Failure, void>> updateSettings(SettingsModel settings) async {
    try {
      await localDataSource.cacheSettings(settings);
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to save settings'));
    }
  }
}
