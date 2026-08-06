import '../../data/models/user_profile_response_model.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<UserProfileResponseModel> call() {
    return repository.getProfile();
  }
}
