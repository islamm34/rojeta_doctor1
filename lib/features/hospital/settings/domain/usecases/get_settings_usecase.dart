import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/settings_model.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUseCase {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);

  Future<Either<Failure, SettingsModel>> call() async {
    return await repository.getSettings();
  }
}
