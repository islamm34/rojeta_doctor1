import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../entities/lab_profile.dart';
import '../entities/general_settings.dart';

abstract class SettingsRepository {
  Future<Either<Failure, LabProfile>> getLabProfile();
  Future<Either<Failure, GeneralSettings>> getGeneralSettings();
  Future<Either<Failure, void>> updateGeneralSettings(GeneralSettings settings);
}
