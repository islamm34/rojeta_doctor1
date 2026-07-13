import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../entities/lab_profile.dart';
import '../entities/general_settings.dart';
import '../repositories/settings_repository.dart';

class GetSettingsDataUseCase {
  final SettingsRepository repository;

  GetSettingsDataUseCase(this.repository);

  Future<Either<Failure, LabProfile>> getLabProfile() async {
    return await repository.getLabProfile();
  }

  Future<Either<Failure, GeneralSettings>> getGeneralSettings() async {
    return await repository.getGeneralSettings();
  }
}
