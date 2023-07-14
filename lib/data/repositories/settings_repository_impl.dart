import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/errors.dart';
import '../../domain/repositories/settings.dart';
import '../../domain/repositories/settings_repository_facade.dart';

class SettingsRepositoryImpl implements SettingsRepositoryFacade {
  final String key;
  final SharedPreferences sharedPreferences;

  SettingsRepositoryImpl({required this.key, required this.sharedPreferences});

  @override
  bool exists() {
    return sharedPreferences.containsKey(key);
  }

  @override
  Settings read() {
    if (!sharedPreferences.containsKey(key)) {
      throw KeyNotFoundError('Key $key was not found.');
    }

    return Settings.fromJson(
        jsonDecode(sharedPreferences.getString(key) ?? ''));
  }

  @override
  Future<bool> write(Settings settings) async {
    final json = jsonEncode(settings.toJson());
    return await sharedPreferences.setString(key, json);
  }

  @override
  Future<bool> delete() async {
    if (!sharedPreferences.containsKey(key)) {
      throw KeyNotFoundError('Key $key was not found.');
    }

    return await sharedPreferences.remove(key);
  }
}
