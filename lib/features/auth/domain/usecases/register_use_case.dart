import '../../data/models/register/register_request_model.dart';
import '../../data/models/register/register_response_model.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<RegisterResponseModel> call(RegisterRequestModel requestModel) {
    return repository.register(requestModel);
  }
}
