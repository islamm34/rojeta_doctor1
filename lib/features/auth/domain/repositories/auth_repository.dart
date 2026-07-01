import '../../data/models/authmodel.dart';
// import 'package:dartz/dartz.dart';
// import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  // Future<Either<Failure, AuthModel>> getAuth();
  Future<AuthModel> getAuth();
}
