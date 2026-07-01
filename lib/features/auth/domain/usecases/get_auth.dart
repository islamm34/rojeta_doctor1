import '../repositories/auth_repository.dart';
// import 'package:dartz/dartz.dart';
// import '../../../../core/error/failures.dart';
// import '../entities/auth.dart';

class GetAuthUseCase {
  final AuthRepository repository;

  GetAuthUseCase(this.repository);

  Future call() => repository.getAuth();
}
