import '../../data/models/authmodel.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> fetch();
}
