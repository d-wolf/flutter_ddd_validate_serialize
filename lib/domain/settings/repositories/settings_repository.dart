import 'package:bloc_input_valueobject/domain/core/typedefs/typedefs.dart';

import '../entities/settings.dart';

abstract interface class SettingsRepository {
  ResultFuture<bool> exists();
  ResultFuture<Settings> read();
  ResultFuture<void> write(Settings settings);
  ResultFuture<void> delete();
}
