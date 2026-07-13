import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../entities/general_settings.dart';
import '../repositories/settings_repository.dart';

class UpdateGeneralSettingsUseCase {
  final SettingsRepository repository;

  UpdateGeneralSettingsUseCase(this.repository);

  Future<Either<Failure, void>> call(GeneralSettings settings) async {
    return await repository.updateGeneralSettings(settings);
  }
}
