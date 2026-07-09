import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rojeta_doctor/core/network/endpoints.dart';
import '../constants/app_constants.dart';

class FlutterSecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: Endpoints.authTokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: Endpoints.authTokenKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: Endpoints.authTokenKey);
  }
}
