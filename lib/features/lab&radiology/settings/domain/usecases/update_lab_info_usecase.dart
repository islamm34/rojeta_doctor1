import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../data/models/lab_info_model.dart';
import '../repositories/settings_repository.dart';

class UpdateLabInfoUseCase {
  final SettingsRepository repository;

  UpdateLabInfoUseCase(this.repository);

  Future<Either<Failure, void>> call(LabInfoModel info) async {
    return await repository.updateLabInfo(info);
  }
}
