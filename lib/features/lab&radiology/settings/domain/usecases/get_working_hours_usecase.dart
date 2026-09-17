import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../data/models/working_hours_model.dart';
import '../repositories/settings_repository.dart';

class GetWorkingHoursUseCase {
  final SettingsRepository repository;

  GetWorkingHoursUseCase(this.repository);

  Future<Either<Failure, WorkingHoursModel>> call() async {
    return await repository.getWorkingHours();
  }
}
