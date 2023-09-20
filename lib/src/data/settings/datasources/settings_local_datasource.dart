import 'package:bloc_input_valueobject/src/data/settings/models/settings_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  bool exists();
  SettingsModel read();
  Future<bool> write(SettingsModel settings);
  Future<bool> delete();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final String _key = 'cache_key';

  final SharedPreferences _prefs;

  SettingsLocalDataSourceImpl(this._prefs);

  @override
  Future<bool> delete() async {
    return await _prefs.remove(_key);
  }

  @override
  bool exists() {
    return _prefs.containsKey(_key);
  }

  @override
  SettingsModel read() {
    final json = _prefs.getString(_key)!;
    debugPrint(json);
    return SettingsModel.fromJson(json);
  }

  @override
  Future<bool> write(SettingsModel settings) async {
    final json = settings.toJson();
    debugPrint(json);
    return await _prefs.setString(_key, json);
  }
}
