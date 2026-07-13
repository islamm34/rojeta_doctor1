import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/settings_model.dart';

abstract class SettingsRepository {
  Future<Either<Failure, SettingsModel>> getSettings();
  Future<Either<Failure, void>> updateSettings(SettingsModel settings);
}
