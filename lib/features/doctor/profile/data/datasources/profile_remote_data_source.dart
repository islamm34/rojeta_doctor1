import '../models/user_profile_response_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileResponseModel> getProfile();
}
