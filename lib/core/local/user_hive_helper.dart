import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rojeta_doctor/core/utils/firebase_messaging_service.dart';
import 'package:rojeta_doctor/core/utils/local_notification_service.dart';

import '../di/injector.dart';
import 'user_data.dart';

class UserHiveHelper {
  // Box names
  static const String _userBoxName = 'userBox';
  static const String _settingsBoxName = 'appSettingsBox';
  static const String _userId = 'currentUser';
  static const String _appLanguageKey = 'app_language';

  static Future<void> initNotifications() async {
    try {
      await LocalNotificationService.init();
      await injector<FirebaseMessagingService>().init();
    } catch (_) {}
  }

  // Initialize Hive and register adapters
  static Future<void> init() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
    } catch (e, st) {
      log('Error initializing Hive: $e\n$st');
    }

    try {
      Hive.registerAdapter(UserDataAdapter());
    } catch (e, st) {
      log('Error registering Hive adapters: $e\n$st');
    }

    try {
      if (!Hive.isBoxOpen(_userBoxName)) {
        await Hive.openBox<UserData>(_userBoxName);
      }
      if (!Hive.isBoxOpen(_settingsBoxName)) {
        await Hive.openBox(_settingsBoxName);
      }
    } catch (e, st) {
      log('Error opening Hive box: $e\n$st');
    }
  }

  /// Checks if a valid user session is stored in Hive
  static bool isLoggedIn() {
    final user = getUser();
    return user != null && user.id != null;
  }

  /// Clears active user session data completely while preserving user settings
  static void clearSession() {
    final currentUser = getUser();
    if (currentUser != null) {
      final userKey =
          currentUser.id?.toString() ??
          currentUser.phone ??
          currentUser.email ??
          '';
      if (userKey.isNotEmpty && currentUser.language != null) {
        saveUserLanguage(userKey, currentUser.language!);
      }
      if (currentUser.language != null) {
        saveAppLanguage(currentUser.language!);
      }
      if (userKey.isNotEmpty &&
          currentUser.image != null &&
          currentUser.image!.trim().isNotEmpty) {
        saveUserImage(userKey, currentUser.image!.trim());
        saveDoctorImage(userKey, currentUser.image!.trim());
      }
    }
    deleteUser();
  }

  // --------------------- User CRUD Operations ---------------------

  /// Creates or updates a user
  static void saveUser(UserData user) {
    if (Hive.isBoxOpen(_userBoxName)) {
      final box = Hive.box<UserData>(_userBoxName);
      box.put(_userId, user);
    }
  }

  /// Gets a user by email
  static UserData? getUser() {
    if (!Hive.isBoxOpen(_userBoxName)) return null;
    final box = Hive.box<UserData>(_userBoxName);
    return box.get(_userId);
  }

  /// Gets all users
  static List<UserData> getAllUsers() {
    if (!Hive.isBoxOpen(_userBoxName)) return [];
    final box = Hive.box<UserData>(_userBoxName);
    return box.values.toList();
  }

  /// Updates specific fields of a user
  static void updateUser(UserData user) {
    if (Hive.isBoxOpen(_userBoxName)) {
      final box = Hive.box<UserData>(_userBoxName);
      box.put(_userId, user);
    }
  }

  /// Deletes a user by email
  static void deleteUser() {
    if (Hive.isBoxOpen(_userBoxName)) {
      final box = Hive.box<UserData>(_userBoxName);
      box.delete(_userId);
    }
  }

  /// Clears all users
  static void clearAllUsers() {
    if (Hive.isBoxOpen(_userBoxName)) {
      final box = Hive.box<UserData>(_userBoxName);
      box.clear();
    }
  }

  // --------------------- Persistent Settings Operations ---------------------

  /// Saves the active application language
  static void saveAppLanguage(String lang) {
    final clean = lang.trim();
    if (clean.isEmpty) return;
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        Hive.box(_settingsBoxName).put(_appLanguageKey, clean);
      }
    } catch (_) {}
  }

  /// Retrieves the persisted app language (defaults to 'ar')
  static String getAppLanguage() {
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        final val = Hive.box(_settingsBoxName).get(_appLanguageKey);
        if (val is String && val.trim().isNotEmpty) {
          return val.trim();
        }
      }
    } catch (_) {}
    final user = getUser();
    if (user?.language != null && user!.language!.trim().isNotEmpty) {
      return user.language!.trim();
    }
    return 'ar';
  }

  /// Saves language preference for a specific user ID, phone, or email
  static void saveUserLanguage(String userIdOrPhone, String lang) {
    final cleanKey = userIdOrPhone.trim();
    final cleanLang = lang.trim();
    if (cleanKey.isEmpty || cleanLang.isEmpty) return;
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        Hive.box(_settingsBoxName).put('user_lang_$cleanKey', cleanLang);
      }
    } catch (_) {}
  }

  /// Retrieves language preference for a specific user ID, phone, or email
  static String? getUserLanguage(String userIdOrPhone) {
    final cleanKey = userIdOrPhone.trim();
    if (cleanKey.isEmpty) return null;
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        final val = Hive.box(_settingsBoxName).get('user_lang_$cleanKey');
        if (val is String && val.trim().isNotEmpty) {
          return val.trim();
        }
      }
    } catch (_) {}
    return null;
  }

  /// Saves the profile image for a specific user ID, phone, or email
  static void saveUserImage(String userIdOrPhone, String imagePath) {
    final cleanKey = userIdOrPhone.trim();
    final cleanPath = imagePath.trim();
    if (cleanKey.isEmpty || cleanPath.isEmpty) return;
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        Hive.box(_settingsBoxName).put('user_image_$cleanKey', cleanPath);
        Hive.box(_settingsBoxName).put('user_image_latest', cleanPath);
      }
    } catch (_) {}
  }

  /// Retrieves the profile image for a specific user ID, phone, or email
  static String? getUserImage(String userIdOrPhone) {
    final cleanKey = userIdOrPhone.trim();
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        if (cleanKey.isNotEmpty) {
          final val = Hive.box(_settingsBoxName).get('user_image_$cleanKey');
          if (val is String && val.trim().isNotEmpty) {
            return val.trim();
          }
        }
        final latest = Hive.box(_settingsBoxName).get('user_image_latest');
        if (latest is String && latest.trim().isNotEmpty) {
          return latest.trim();
        }
      }
    } catch (_) {}
    return null;
  }

  /// Saves doctor profile image path to persistent Hive box
  static void saveDoctorImage(String doctorId, String imagePath) {
    final cleanId = doctorId.trim();
    final cleanPath = imagePath.trim();
    if (cleanPath.isEmpty) return;
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        final box = Hive.box(_settingsBoxName);
        if (cleanId.isNotEmpty) {
          box.put('doctor_image_$cleanId', cleanPath);
        }
        box.put('doctor_image_latest', cleanPath);
      }
    } catch (_) {}
  }

  /// Retrieves doctor profile image path from persistent Hive box
  static String? getDoctorImage(String doctorId) {
    final cleanId = doctorId.trim();
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        final box = Hive.box(_settingsBoxName);
        if (cleanId.isNotEmpty) {
          final val = box.get('doctor_image_$cleanId');
          if (val is String && val.trim().isNotEmpty) {
            return val.trim();
          }
        }
        final latest = box.get('doctor_image_latest');
        if (latest is String && latest.trim().isNotEmpty) {
          return latest.trim();
        }
      }
    } catch (_) {}
    return null;
  }

  /// Saves doctor clinic address to persistent Hive box
  static void saveDoctorClinicAddress(String address) {
    final clean = address.trim();
    if (clean.isEmpty) return;
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        Hive.box(_settingsBoxName).put('doctor_clinic_address', clean);
      }
    } catch (_) {}
  }

  /// Retrieves doctor clinic address from persistent Hive box
  static String? getDoctorClinicAddress() {
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        final val = Hive.box(_settingsBoxName).get('doctor_clinic_address');
        if (val is String && val.trim().isNotEmpty) {
          return val.trim();
        }
      }
    } catch (_) {}
    return null;
  }

  /// Saves settings (like notification preferences) for a specific user
  static void saveUserSettings(
    String userIdOrPhone,
    Map<String, dynamic> settings,
  ) {
    final cleanKey = userIdOrPhone.trim();
    if (cleanKey.isEmpty) return;
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        Hive.box(_settingsBoxName).put('user_settings_$cleanKey', settings);
      }
    } catch (_) {}
  }

  /// Retrieves settings for a specific user
  static Map<String, dynamic>? getUserSettings(String userIdOrPhone) {
    final cleanKey = userIdOrPhone.trim();
    if (cleanKey.isEmpty) return null;
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        final val = Hive.box(_settingsBoxName).get('user_settings_$cleanKey');
        if (val is Map) {
          return Map<String, dynamic>.from(val);
        }
      }
    } catch (_) {}
    return null;
  }

  /// Permanently saves doctor certificates to Hive
  static void saveDoctorCertificates(String doctorId, List<String> certs) {
    final cleanId = doctorId.trim();
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        final box = Hive.box(_settingsBoxName);
        if (cleanId.isNotEmpty) {
          box.put('doctor_certs_$cleanId', certs);
        }
        box.put('doctor_certs_latest', certs);
      }
    } catch (_) {}
  }

  /// Retrieves doctor certificates from Hive
  static List<String> getDoctorCertificates(String doctorId) {
    final cleanId = doctorId.trim();
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        final box = Hive.box(_settingsBoxName);
        if (cleanId.isNotEmpty) {
          final val = box.get('doctor_certs_$cleanId');
          if (val is List && val.isNotEmpty) {
            return List<String>.from(val);
          }
        }
        final latestVal = box.get('doctor_certs_latest');
        if (latestVal is List && latestVal.isNotEmpty) {
          return List<String>.from(latestVal);
        }
      }
    } catch (_) {}
    return [];
  }

  // --------------------- Helper Methods ---------------------

  /// Closes all boxes
  static void closeBoxes() {
    Hive.close();
  }

  /// Deletes all boxes (for testing/logout)
  static void deleteAllBoxes() {
    Hive.deleteBoxFromDisk(_userBoxName);
  }

  /// Get listenable box for UI bindings
  static ValueListenable<Box<UserData>> getBoxListenable() {
    return Hive.box<UserData>(_userBoxName).listenable();
  }

  /// Checks if settings box is open
  static bool isSettingsBoxOpen() {
    return Hive.isBoxOpen(_settingsBoxName);
  }

  /// Get listenable settings box for UI language and setting changes
  static ValueListenable<Box>? getSettingsBoxListenable() {
    try {
      if (Hive.isBoxOpen(_settingsBoxName)) {
        return Hive.box(_settingsBoxName).listenable();
      }
    } catch (_) {}
    return null;
  }
}
