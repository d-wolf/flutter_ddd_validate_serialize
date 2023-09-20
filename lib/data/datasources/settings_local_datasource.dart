import 'dart:convert';

import 'package:bloc_input_valueobject/domain/repositories/errors.dart';
import 'package:bloc_input_valueobject/domain/repositories/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  bool exists();
  Settings read();
  Future<bool> write(Settings settings);
  Future<bool> delete();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final String key = '';
  final SharedPreferences _prefs;

  SettingsLocalDataSourceImpl(this._prefs);

  @override
  Future<bool> delete() async {
    if (!_prefs.containsKey(key)) {
      throw KeyNotFoundError('Key $key was not found.');
    }

    return await _prefs.remove(key);
  }

  @override
  bool exists() {
    return _prefs.containsKey(key);
  }

  @override
  Settings read() {
    if (!_prefs.containsKey(key)) {
      throw KeyNotFoundError('Key $key was not found.');
    }

    return Settings.fromJson(jsonDecode(_prefs.getString(key) ?? ''));
  }

  @override
  Future<bool> write(Settings settings) async {
    final json = jsonEncode(settings.toJson());
    return await _prefs.setString(key, json);
  }
}
