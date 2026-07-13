import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/settings_model.dart';
import '../repositories/settings_repository.dart';

class UpdateSettingsUseCase {
  final SettingsRepository repository;

  UpdateSettingsUseCase(this.repository);

  Future<Either<Failure, void>> call(SettingsModel settings) async {
    return await repository.updateSettings(settings);
  }
}
