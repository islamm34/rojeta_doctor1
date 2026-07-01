import '../../../domain/datasources/auth_remote_data_source.dart';
import '../../models/authmodel.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // final ApiConsumer apiConsumer;
  // AuthRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<AuthModel> fetch() async {
    // final response = await apiConsumer.get('/auth');
    // return AuthModel.fromJson(response);
    await Future.delayed(const Duration(milliseconds: 300));
    return AuthModel.fake();
  }
}
