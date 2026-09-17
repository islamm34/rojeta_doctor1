import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../../data/models/lab_services_response_model.dart';
import '../repositories/lab_services_repository.dart';

class GetLabServicesUseCase {
  final LabServicesRepository repository;

  GetLabServicesUseCase(this.repository);

  Future<Either<Failure, LabServicesResponseModel>> call({
    UserType? userType,
  }) async {
    return await repository.getServices(userType: userType);
  }
}
