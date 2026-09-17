import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../data/models/general_settings_model.dart';
import '../../data/models/lab_profile_model.dart';
import '../repositories/settings_repository.dart';

class GetSettingsDataUseCase {
  final SettingsRepository repository;

  GetSettingsDataUseCase(this.repository);

  Future<Either<Failure, LabProfileModel>> getLabProfile() async {
    return await repository.getLabProfile();
  }

  Future<Either<Failure, GeneralSettingsModel>> getGeneralSettings() async {
    return await repository.getGeneralSettings();
  }
}
