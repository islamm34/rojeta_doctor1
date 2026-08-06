import '../../data/models/authmodel.dart';
import '../../data/models/login/login_request_model.dart';
import '../../data/models/login/login_response_model.dart';
import '../../data/models/register/register_request_model.dart';
import '../../data/models/register/register_response_model.dart';
import '../../data/models/otp/verify_otp_request_model.dart';
import '../../data/models/otp/verify_otp_response_model.dart';
import '../../data/models/otp/resend_otp_request_model.dart';
import '../../data/models/otp/resend_otp_response_model.dart';

abstract class AuthRepository {
  Future<AuthModel> getAuth();
  Future<RegisterResponseModel> register(RegisterRequestModel requestModel);
  Future<VerifyOtpResponseModel> verifyOtp(VerifyOtpRequestModel requestModel);
  Future<LoginResponseModel> login(LoginRequestModel requestModel);
  Future<ResendOtpResponseModel> resendOtp(ResendOtpRequestModel requestModel);
}
