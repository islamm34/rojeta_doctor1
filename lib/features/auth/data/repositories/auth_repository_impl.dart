import 'package:rojeta_doctor/core/local/user_data.dart';

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

  AuthRepositoryImpl({required this.remote, required this.local});

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
    RegisterRequestModel requestModel,
  ) async {
    final response = await remote.register(requestModel);

    if (response.token != null && response.token!.isNotEmpty) {
      await FlutterSecureStorageHelper.saveToken(response.token!);
    } else {
      await FlutterSecureStorageHelper.deleteToken();
    }

    final savedUser = response.user ?? UserData();
    savedUser.name = (savedUser.name?.isNotEmpty == true)
        ? savedUser.name
        : (requestModel.name?.isNotEmpty == true
              ? requestModel.name
              : requestModel.organizationName);
    savedUser.firstName = (savedUser.firstName?.isNotEmpty == true)
        ? savedUser.firstName
        : requestModel.firstName;
    savedUser.secondName = (savedUser.secondName?.isNotEmpty == true)
        ? savedUser.secondName
        : requestModel.lastName;
    savedUser.phone = (savedUser.phone?.isNotEmpty == true)
        ? savedUser.phone
        : (requestModel.phoneNumber);
    savedUser.email = (savedUser.email?.isNotEmpty == true)
        ? savedUser.email
        : requestModel.email;
    savedUser.role = (savedUser.role?.isNotEmpty == true)
        ? savedUser.role
        : requestModel.role;
    if (response.token != null && response.token!.isNotEmpty) {
      savedUser.token = response.token;
    }
    UserHiveHelper.saveUser(savedUser);

    return response;
  }

  @override
  Future<VerifyOtpResponseModel> verifyOtp(
    VerifyOtpRequestModel requestModel,
  ) async {
    final response = await remote.verifyOtp(requestModel);

    if (response.token != null && response.token!.isNotEmpty) {
      await FlutterSecureStorageHelper.saveToken(response.token!);
    } else {
      await FlutterSecureStorageHelper.deleteToken();
    }

    final existingUser = UserHiveHelper.getUser();
    final userToSave = response.user ?? existingUser ?? UserData();
    if (existingUser != null && response.user != null) {
      if ((userToSave.name == null || userToSave.name!.isEmpty) &&
          existingUser.name != null) {
        userToSave.name = existingUser.name;
      }
      if ((userToSave.firstName == null || userToSave.firstName!.isEmpty) &&
          existingUser.firstName != null) {
        userToSave.firstName = existingUser.firstName;
      }
      if ((userToSave.secondName == null || userToSave.secondName!.isEmpty) &&
          existingUser.secondName != null) {
        userToSave.secondName = existingUser.secondName;
      }
      if ((userToSave.phone == null || userToSave.phone!.isEmpty) &&
          existingUser.phone != null) {
        userToSave.phone = existingUser.phone;
      }
      if ((userToSave.email == null || userToSave.email!.isEmpty) &&
          existingUser.email != null) {
        userToSave.email = existingUser.email;
      }
      if ((userToSave.role == null || userToSave.role!.isEmpty) &&
          existingUser.role != null) {
        userToSave.role = existingUser.role;
      }
    }
    if (userToSave.phone == null || userToSave.phone!.isEmpty) {
      userToSave.phone = requestModel.phone;
    }
    if (response.token != null && response.token!.isNotEmpty) {
      userToSave.token = response.token;
    }
    UserHiveHelper.saveUser(userToSave);

    return response;
  }

  @override
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    final response = await remote.login(requestModel);

    if (response.token != null && response.token!.isNotEmpty) {
      await FlutterSecureStorageHelper.saveToken(response.token!);
    }

    final existingUser = UserHiveHelper.getUser();
    final userToSave = response.user ?? existingUser ?? UserData();
    if (existingUser != null && response.user != null) {
      if ((userToSave.name == null || userToSave.name!.isEmpty) &&
          existingUser.name != null) {
        userToSave.name = existingUser.name;
      }
      if ((userToSave.firstName == null || userToSave.firstName!.isEmpty) &&
          existingUser.firstName != null) {
        userToSave.firstName = existingUser.firstName;
      }
      if ((userToSave.secondName == null || userToSave.secondName!.isEmpty) &&
          existingUser.secondName != null) {
        userToSave.secondName = existingUser.secondName;
      }
      if ((userToSave.phone == null || userToSave.phone!.isEmpty) &&
          existingUser.phone != null) {
        userToSave.phone = existingUser.phone;
      }
      if ((userToSave.email == null || userToSave.email!.isEmpty) &&
          existingUser.email != null) {
        userToSave.email = existingUser.email;
      }
      if ((userToSave.role == null || userToSave.role!.isEmpty) &&
          existingUser.role != null) {
        userToSave.role = existingUser.role;
      }
      if ((userToSave.image == null || userToSave.image!.isEmpty) &&
          existingUser.image != null) {
        userToSave.image = existingUser.image;
      }
    }
    if (userToSave.phone == null || userToSave.phone!.isEmpty) {
      userToSave.phone = requestModel.phone;
    }
    if (response.token != null && response.token!.isNotEmpty) {
      userToSave.token = response.token;
    }
    UserHiveHelper.saveUser(userToSave);

    return response;
  }

  @override
  Future<ResendOtpResponseModel> resendOtp(
    ResendOtpRequestModel requestModel,
  ) async {
    return await remote.resendOtp(requestModel);
  }

  @override
  Future<CheckPhoneResponseModel> checkPhone(
    CheckPhoneRequestModel requestModel,
  ) async {
    return await remote.checkPhone(requestModel);
  }

  @override
  Future<void> logout() async {
    await FlutterSecureStorageHelper.clearAll();
    UserHiveHelper.clearSession();
  }
}
