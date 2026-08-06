import '../../data/models/check_phone/check_phone_request_model.dart';
import '../../data/models/check_phone/check_phone_response_model.dart';
import '../repositories/auth_repository.dart';

class CheckPhoneUseCase {
  final AuthRepository repository;

  CheckPhoneUseCase(this.repository);

  Future<CheckPhoneResponseModel> call(CheckPhoneRequestModel requestModel) {
    return repository.checkPhone(requestModel);
  }
}
