import '../../../domain/datasources/auth_local_data_source.dart';
import '../../models/authmodel.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // final FlutterSecureStorage storage;
  // AuthLocalDataSourceImpl({required this.storage});
  
  AuthModel? _cache;

  @override
  Future<void> save(AuthModel model) async {
    _cache = model;
  }

  @override
  Future<AuthModel?> load() async {
    return _cache;
  }
}
