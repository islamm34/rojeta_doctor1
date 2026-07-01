import '../../data/models/authmodel.dart';

abstract class AuthLocalDataSource {
  Future<void> save(AuthModel model);
  Future<AuthModel?> load();
}
