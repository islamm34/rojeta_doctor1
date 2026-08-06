import '../../../../core/local/user_hive_helper.dart';
import '../../../../core/utils/flutter_secure_storage_helper.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/datasources/auth_remote_data_source.dart';
import '../../domain/datasources/auth_local_data_source.dart';
import '../models/authmodel.dart';
import '../models/login/login_request_model.dart';
import '../models/login/login_response_model.dart';
import '../models/register/register_request_model.dart';
import '../models/register/register_response_model.dart';
import '../models/otp/verify_otp_request_model.dart';
import '../models/otp/verify_otp_response_model.dart';
import '../models/otp/resend_otp_request_model.dart';
import '../models/otp/resend_otp_response_model.dart';
import '../models/check_phone/check_phone_request_model.dart';
import '../models/check_phone/check_phone_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<AuthModel> getAuth() async {
    final cached = await local.load();
    if (cached != null) return cached;

    final data = await remote.fetch();
    await local.save(data);
    return data;
  }

  @override
  Future<RegisterResponseModel> register(
      RegisterRequestModel requestModel) async {
    final response = await remote.register(requestModel);

    if (response.token != null && response.token!.isNotEmpty) {
      await FlutterSecureStorageHelper.saveToken(response.token!);
    }

    if (response.user != null) {
      UserHiveHelper.saveUser(response.user!);
    }

    return response;
  }

  @override
  Future<VerifyOtpResponseModel> verifyOtp(
      VerifyOtpRequestModel requestModel) async {
    final response = await remote.verifyOtp(requestModel);

    if (response.token != null && response.token!.isNotEmpty) {
      await FlutterSecureStorageHelper.saveToken(response.token!);
    }

    if (response.user != null) {
      UserHiveHelper.saveUser(response.user!);
    }

    return response;
  }

  @override
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    final response = await remote.login(requestModel);

    if (response.token != null && response.token!.isNotEmpty) {
      await FlutterSecureStorageHelper.saveToken(response.token!);
    }

    if (response.user != null) {
      UserHiveHelper.saveUser(response.user!);
    }

    return response;
  }

  @override
  Future<ResendOtpResponseModel> resendOtp(
      ResendOtpRequestModel requestModel) async {
    return await remote.resendOtp(requestModel);
  }

  @override
  Future<CheckPhoneResponseModel> checkPhone(
      CheckPhoneRequestModel requestModel) async {
    return await remote.checkPhone(requestModel);
  }
}
