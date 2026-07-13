import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/lab_home_model.dart';
import '../repositories/lab_home_repository.dart';

class GetLabDashboardUseCase {
  final LabHomeRepository repository;

  GetLabDashboardUseCase(this.repository);

  Future<Either<Failure, LabHomeModel>> call() async {
    return await repository.getDashboardData();
  }
}
