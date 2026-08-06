import 'package:rojeta_doctor/core/network/api_consumer.dart';
import 'package:rojeta_doctor/core/network/endpoints.dart';

import '../../../domain/datasources/auth_remote_data_source.dart';
import '../../models/authmodel.dart';
import '../../models/login/login_request_model.dart';
import '../../models/login/login_response_model.dart';
import '../../models/register/register_request_model.dart';
import '../../models/register/register_response_model.dart';
import '../../models/otp/verify_otp_request_model.dart';
import '../../models/otp/verify_otp_response_model.dart';
import '../../models/otp/resend_otp_request_model.dart';
import '../../models/otp/resend_otp_response_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<AuthModel> fetch() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return AuthModel.fake();
  }

  @override
  Future<RegisterResponseModel> register(
      RegisterRequestModel requestModel) async {
    final formData = await requestModel.toFormData();
    final response = await apiConsumer.post(
      Endpoints.register,
      data: formData,
    );
    return RegisterResponseModel.fromJson(response);
  }

  @override
  Future<VerifyOtpResponseModel> verifyOtp(
      VerifyOtpRequestModel requestModel) async {
    final response = await apiConsumer.post(
      Endpoints.verifyOtp,
      data: requestModel.toJson(),
    );
    return VerifyOtpResponseModel.fromJson(response);
  }

  @override
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    final response = await apiConsumer.post(
      Endpoints.login,
      data: requestModel.toJson(),
    );
    return LoginResponseModel.fromJson(response);
  }

  @override
  Future<ResendOtpResponseModel> resendOtp(
      ResendOtpRequestModel requestModel) async {
    final response = await apiConsumer.post(
      Endpoints.resendOtp,
      data: requestModel.toJson(),
    );
    return ResendOtpResponseModel.fromJson(response);
  }
}
