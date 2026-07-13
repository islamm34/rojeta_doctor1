import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/lab_home_model.dart';

abstract class LabHomeRepository {
  Future<Either<Failure, LabHomeModel>> getDashboardData();
}
