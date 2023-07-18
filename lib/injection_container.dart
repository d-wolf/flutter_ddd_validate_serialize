import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories/settings_repository_impl.dart';
import 'domain/repositories/settings_repository_facade.dart';
import 'domain/use_cases/load_settings/load_settings_use_case.dart';
import 'domain/use_cases/save_settings/save_settings_use_case.dart';
import 'globals.dart';

class InjectionContainer {
  Future<void> init() async {
    // TODO: REGISTER REPOS HERE
    final sp = await SharedPreferences.getInstance();

    getIt.registerLazySingleton<SettingsRepositoryFacade>(() =>
        SettingsRepositoryImpl(key: 'my_store_key', sharedPreferences: sp));

    // TODO: REGISTER USE CASES HERE
    getIt.registerFactory<LoadSettingsUseCase>(
        () => LoadSettingsUseCase(settingsRepository: getIt()));

    getIt.registerFactory<SaveSettingsUseCase>(
        () => SaveSettingsUseCase(settingsRepository: getIt()));
  }
}
