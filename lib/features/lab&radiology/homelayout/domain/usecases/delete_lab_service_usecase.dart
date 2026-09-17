import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../repositories/lab_services_repository.dart';

class DeleteLabServiceUseCase {
  final LabServicesRepository repository;

  DeleteLabServiceUseCase(this.repository);

  Future<Either<Failure, void>> call(String id, {UserType? userType}) async {
    return await repository.deleteService(id, userType: userType);
  }
}
