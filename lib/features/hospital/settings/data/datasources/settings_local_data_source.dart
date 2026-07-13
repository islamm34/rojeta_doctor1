import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<SettingsModel> getSettings();
  Future<void> cacheSettings(SettingsModel settingsToCache);
}

const String cachedSettingsKey = 'CACHED_SETTINGS';

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final FlutterSecureStorage secureStorage;

  SettingsLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<SettingsModel> getSettings() async {
    final jsonString = await secureStorage.read(key: cachedSettingsKey);
    if (jsonString != null) {
      return SettingsModel.fromJson(json.decode(jsonString));
    } else {
      // Default settings
      return const SettingsModel(
        pushNotificationsEnabled: true,
        languageCode: 'en',
      );
    }
  }

  @override
  Future<void> cacheSettings(SettingsModel settingsToCache) async {
    await secureStorage.write(
      key: cachedSettingsKey,
      value: json.encode(settingsToCache.toJson()),
    );
  }
}
