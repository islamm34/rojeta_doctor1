import '../../data/models/user_profile_response_model.dart';

abstract class ProfileRepository {
  Future<UserProfileResponseModel> getProfile();
}
