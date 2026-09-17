import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../../data/models/lab_services_response_model.dart';

abstract class LabServicesRepository {
  Future<Either<Failure, LabServicesResponseModel>> getServices({
    UserType? userType,
  });
  Future<Either<Failure, void>> deleteService(String id, {UserType? userType});
}
