import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/color/color.dart';
import '../value_objects/interval/interval.dart';
import '../value_objects/token/token.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    required Token token,
    required Interval interval,
    required Color color,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);
}
