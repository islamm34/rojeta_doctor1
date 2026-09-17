import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../auth/data/models/user_type_model.dart';
import '../../data/models/home_visit_config_model.dart';

abstract class HomeVisitsRepository {
  Future<Either<Failure, HomeVisitConfigModel>> getHomeVisitsConfig({UserType? userType});
  Future<Either<Failure, void>> updateHomeVisitsConfig(HomeVisitConfigModel config, {UserType? userType});
}
