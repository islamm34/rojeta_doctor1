import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../../data/models/lab_home_model.dart';
import '../repositories/lab_home_repository.dart';

class GetLabDashboardUseCase {
  final LabHomeRepository repository;

  GetLabDashboardUseCase(this.repository);

  Future<Either<Failure, LabHomeModel>> call({UserType? userType}) async {
    return await repository.getDashboardData(userType: userType);
  }
}
