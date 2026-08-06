import '../../data/models/login/login_request_model.dart';
import '../../data/models/login/login_response_model.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<LoginResponseModel> call(LoginRequestModel requestModel) {
    return repository.login(requestModel);
  }
}
