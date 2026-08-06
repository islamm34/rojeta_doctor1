import 'package:rojeta_doctor/core/local/user_hive_helper.dart';

import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/user_profile_response_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserProfileResponseModel> getProfile() async {
    final response = await remoteDataSource.getProfile();
    if (response.user != null) {
      UserHiveHelper.saveUser(response.user!);
    }
    return response;
  }
}
