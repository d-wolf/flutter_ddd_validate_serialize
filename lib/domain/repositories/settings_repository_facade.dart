import 'settings.dart';

abstract interface class SettingsRepositoryFacade {
  bool exists();
  Settings read();
  Future<bool> write(Settings settings);
  Future<bool> delete();
}
