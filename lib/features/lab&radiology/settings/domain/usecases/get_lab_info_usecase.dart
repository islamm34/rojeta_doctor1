import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../data/models/lab_info_model.dart';
import '../repositories/settings_repository.dart';

class GetLabInfoUseCase {
  final SettingsRepository repository;

  GetLabInfoUseCase(this.repository);

  Future<Either<Failure, LabInfoModel>> call() async {
    return await repository.getLabInfo();
  }
}
