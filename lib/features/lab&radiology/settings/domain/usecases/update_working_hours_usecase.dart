import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../data/models/working_hours_model.dart';
import '../repositories/settings_repository.dart';

class UpdateWorkingHoursUseCase {
  final SettingsRepository repository;

  UpdateWorkingHoursUseCase(this.repository);

  Future<Either<Failure, void>> call(WorkingHoursModel workingHours) async {
    return await repository.updateWorkingHours(workingHours);
  }
}
