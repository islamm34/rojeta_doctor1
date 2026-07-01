import '../../domain/repositories/auth_repository.dart';
import '../../domain/datasources/auth_remote_data_source.dart';
import '../../domain/datasources/auth_local_data_source.dart';
import '../models/authmodel.dart';
// import 'package:dartz/dartz.dart';
// import '../../../../core/error/failures.dart';
// import '../../../../core/error/exceptions.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<AuthModel> getAuth() async {
    final cached = await local.load();
    if (cached != null) return cached;

    final data = await remote.fetch();
    await local.save(data);
    return data;
  }
}
