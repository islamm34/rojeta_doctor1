import '../../data/models/otp/resend_otp_request_model.dart';
import '../../data/models/otp/resend_otp_response_model.dart';
import '../repositories/auth_repository.dart';

class ResendOtpUseCase {
  final AuthRepository repository;

  ResendOtpUseCase(this.repository);

  Future<ResendOtpResponseModel> call(ResendOtpRequestModel requestModel) {
    return repository.resendOtp(requestModel);
  }
}
