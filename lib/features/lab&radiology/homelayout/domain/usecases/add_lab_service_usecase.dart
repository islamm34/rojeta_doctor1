import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../../data/models/create_lab_service_model.dart';
import '../repositories/lab_services_repository.dart';

class AddLabServiceUseCase {
  final LabServicesRepository repository;

  AddLabServiceUseCase(this.repository);

  Future<Either<Failure, void>> call(
    CreateLabServiceModel service, {
    UserType? userType,
  }) {
    return repository.addService(service, userType: userType);
  }
}
