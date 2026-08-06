import 'package:rojeta_doctor/features/auth/data/models/otp/verify_otp_request_model.dart';
import 'package:rojeta_doctor/features/auth/data/models/otp/verify_otp_response_model.dart';


import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<VerifyOtpResponseModel> call(VerifyOtpRequestModel requestModel) {
    return repository.verifyOtp(requestModel);
  }
}
