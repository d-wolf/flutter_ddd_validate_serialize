import 'package:bloc_input_valueobject/src/domain/core/typedefs/typedefs.dart';

import 'package:bloc_input_valueobject/src/domain/settings/entities/settings.dart';

abstract interface class SettingsRepository {
  ResultFuture<bool> exists();
  ResultFuture<Settings> read();
  ResultFuture<void> write(Settings settings);
  ResultFuture<void> delete();
}
