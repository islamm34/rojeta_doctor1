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
  static const String _userId = 'currentUser';

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
    } catch (e, st) {
      log('Error opening Hive box: $e\n$st');
    }
  }

  /// Checks if a valid user session is stored in Hive
  static bool isLoggedIn() {
    final user = getUser();
    return user != null && user.id != null;
  }

  /// Clears active user session data completely
  static void clearSession() {
    clearAllUsers();
  }

  // --------------------- User CRUD Operations ---------------------

  /// Creates or updates a user
  static void saveUser(UserData user) {
    final box = Hive.box<UserData>(_userBoxName);
    box.put(_userId, user);
  }

  /// Gets a user by email
  static UserData? getUser() {
    final box = Hive.box<UserData>(_userBoxName);
    return box.get(_userId);
  }

  /// Gets all users
  static List<UserData> getAllUsers() {
    final box = Hive.box<UserData>(_userBoxName);
    return box.values.toList();
  }

  /// Updates specific fields of a user
  static void updateUser(UserData user) {
    final box = Hive.box<UserData>(_userBoxName);
    box.put(_userId, user);
  }

  /// Deletes a user by email
  static void deleteUser() {
    final box = Hive.box<UserData>(_userBoxName);
    box.delete(_userId);
  }

  /// Clears all users
  static void clearAllUsers() {
    final box = Hive.box<UserData>(_userBoxName);
    box.clear();
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
}
