import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../data/models/general_settings_model.dart';
import '../repositories/settings_repository.dart';

class UpdateGeneralSettingsUseCase {
  final SettingsRepository repository;

  UpdateGeneralSettingsUseCase(this.repository);

  Future<Either<Failure, void>> call(GeneralSettingsModel settings) async {
    return await repository.updateGeneralSettings(settings);
  }
}
