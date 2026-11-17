import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rojeta_doctor/core/network/endpoints.dart';

class FlutterSecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: Endpoints.authTokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: Endpoints.authTokenKey);
  }

  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.trim().isNotEmpty;
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: Endpoints.authTokenKey);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  static Future<void> saveAppLanguage(String lang) async {
    await _storage.write(key: 'app_language', value: lang.trim());
  }

  static Future<String?> getAppLanguage() async {
    return await _storage.read(key: 'app_language');
  }

  static Future<void> saveUserLanguage(String userIdOrPhone, String lang) async {
    final clean = userIdOrPhone.trim();
    if (clean.isNotEmpty) {
      await _storage.write(key: 'user_lang_$clean', value: lang.trim());
    }
  }

  static Future<String?> getUserLanguage(String userIdOrPhone) async {
    final clean = userIdOrPhone.trim();
    if (clean.isEmpty) return null;
    return await _storage.read(key: 'user_lang_$clean');
  }

  static Future<void> saveDoctorQr(String doctorId, String qrData) async {
    final cleanId = doctorId.trim();
    if (cleanId.isNotEmpty) {
      await _storage.write(key: 'doctor_qr_$cleanId', value: qrData);
    }
    await _storage.write(key: 'doctor_qr_latest', value: qrData);
  }

  static Future<String?> getDoctorQr(String doctorId) async {
    final cleanId = doctorId.trim();
    if (cleanId.isNotEmpty) {
      final val = await _storage.read(key: 'doctor_qr_$cleanId');
      if (val != null && val.isNotEmpty) return val;
    }
    return await _storage.read(key: 'doctor_qr_latest');
  }

  static Future<void> saveDoctorCertificates(
    String doctorId,
    List<String> certs,
  ) async {
    final cleanId = doctorId.trim();
    final jsonVal = jsonEncode(certs);
    if (cleanId.isNotEmpty) {
      await _storage.write(
        key: 'doctor_certs_$cleanId',
        value: jsonVal,
      );
    }
    await _storage.write(
      key: 'doctor_certs_latest',
      value: jsonVal,
    );
  }

  static Future<List<String>> getDoctorCertificates(String doctorId) async {
    final cleanId = doctorId.trim();
    if (cleanId.isNotEmpty) {
      final val = await _storage.read(key: 'doctor_certs_$cleanId');
      if (val != null && val.isNotEmpty) {
        try {
          final list = List<String>.from(jsonDecode(val) as List);
          if (list.isNotEmpty) return list;
        } catch (_) {}
      }
    }
    final latestVal = await _storage.read(key: 'doctor_certs_latest');
    if (latestVal != null && latestVal.isNotEmpty) {
      try {
        final list = List<String>.from(jsonDecode(latestVal) as List);
        if (list.isNotEmpty) return list;
      } catch (_) {}
    }
    return [];
  }

  static Future<void> saveDoctorIsPro(String doctorId, bool isPro) async {
    final cleanId = doctorId.trim();
    if (cleanId.isNotEmpty) {
      await _storage.write(
        key: 'doctor_is_pro_$cleanId',
        value: isPro.toString(),
      );
    }
    await _storage.write(
      key: 'doctor_is_pro_latest',
      value: isPro.toString(),
    );
  }

  static Future<bool> getDoctorIsPro(String doctorId) async {
    final cleanId = doctorId.trim();
    if (cleanId.isNotEmpty) {
      final val = await _storage.read(key: 'doctor_is_pro_$cleanId');
      if (val != null) return val == 'true';
    }
    final latestVal = await _storage.read(key: 'doctor_is_pro_latest');
    return latestVal == 'true';
  }

  static Future<void> saveDoctorEmail(String doctorId, String email) async {
    final cleanId = doctorId.trim();
    if (cleanId.isNotEmpty) {
      await _storage.write(key: 'doctor_email_$cleanId', value: email);
    }
    await _storage.write(key: 'doctor_email_latest', value: email);
  }

  static Future<String?> getDoctorEmail(String doctorId) async {
    final cleanId = doctorId.trim();
    if (cleanId.isNotEmpty) {
      final val = await _storage.read(key: 'doctor_email_$cleanId');
      if (val != null && val.trim().isNotEmpty) return val;
    }
    return await _storage.read(key: 'doctor_email_latest');
  }

  static Future<void> saveDoctorImage(String doctorId, String imageUrl) async {
    final cleanId = doctorId.trim();
    if (cleanId.isNotEmpty) {
      await _storage.write(key: 'doctor_image_$cleanId', value: imageUrl);
    }
    await _storage.write(key: 'doctor_image_latest', value: imageUrl);
  }

  static Future<String?> getDoctorImage(String doctorId) async {
    final cleanId = doctorId.trim();
    if (cleanId.isNotEmpty) {
      final val = await _storage.read(key: 'doctor_image_$cleanId');
      if (val != null && val.trim().isNotEmpty) return val;
    }
    return await _storage.read(key: 'doctor_image_latest');
  }

  static Future<void> saveUserImage(String userId, String image) async {
    final clean = userId.trim();
    if (clean.isNotEmpty) {
      await _storage.write(key: 'user_image_$clean', value: image.trim());
    }
    await _storage.write(key: 'user_image_latest', value: image.trim());
  }

  static Future<String?> getUserImage(String userId) async {
    final clean = userId.trim();
    if (clean.isNotEmpty) {
      final val = await _storage.read(key: 'user_image_$clean');
      if (val != null && val.trim().isNotEmpty) return val.trim();
    }
    return await _storage.read(key: 'user_image_latest');
  }
}
