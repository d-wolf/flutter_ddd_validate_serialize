import 'package:bloc_input_valueobject/src/data/settings/models/settings_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String kLocalDataSourceKey = 'cache_key';

abstract class SettingsLocalDataSource {
  bool exists();
  SettingsModel read();
  Future<bool> write(SettingsModel settings);
  Future<bool> delete();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  SettingsLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<bool> delete() async {
    return _prefs.remove(kLocalDataSourceKey);
  }

  @override
  bool exists() {
    return _prefs.containsKey(kLocalDataSourceKey);
  }

  @override
  SettingsModel read() {
    final json = _prefs.getString(kLocalDataSourceKey)!;
    debugPrint(json);
    return SettingsModel.fromJson(json);
  }

  @override
  Future<bool> write(SettingsModel settings) async {
    final json = settings.toJson();
    debugPrint(json);
    return _prefs.setString(kLocalDataSourceKey, json);
  }
}
