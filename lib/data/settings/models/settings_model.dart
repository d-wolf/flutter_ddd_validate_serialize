import 'dart:convert';

import 'package:bloc_input_valueobject/domain/core/typedefs/typedefs.dart';
import 'package:bloc_input_valueobject/domain/settings/entities/settings.dart';
import 'package:bloc_input_valueobject/domain/settings/entities/color.dart';
import 'package:bloc_input_valueobject/domain/settings/entities/interval.dart';
import 'package:bloc_input_valueobject/domain/settings/entities/token.dart';

class SettingsModel extends Settings {
  const SettingsModel({
    required super.token,
    required super.interval,
    required super.color,
  });

  SettingsModel.fromSettings(Settings settings)
      : this(
            token: settings.token,
            interval: settings.interval,
            color: settings.color);

  factory SettingsModel.fromJson(String json) =>
      SettingsModel.fromMap(jsonDecode(json) as DataMap);

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'settings': {
          'token': token.getOrThrow(),
          'interval': interval.getOrThrow(),
          'color': color.getOrThrow(),
        }
      };

  factory SettingsModel.fromMap(DataMap map) {
    final settings = map['settings'] as Map<String, dynamic>;
    return SettingsModel(
        token: Token.value(settings['token'] as String),
        interval: Interval.value(settings['interval'] as int),
        color: Color.value(settings['color'] as int));
  }

  @override
  List<Object?> get props => [token, interval, color];
}
