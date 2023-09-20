import 'package:bloc_input_valueobject/src/data/settings/datasources/settings_local_datasource.dart';
import 'package:bloc_input_valueobject/src/data/settings/repositories/settings_repository_impl.dart';
import 'package:bloc_input_valueobject/src/domain/settings/repositories/settings_repository.dart';
import 'package:bloc_input_valueobject/src/domain/settings/usecases/exist_settings.dart';
import 'package:bloc_input_valueobject/src/domain/settings/usecases/load_settings.dart';
import 'package:bloc_input_valueobject/src/domain/settings/usecases/save_settings.dart';
import 'package:bloc_input_valueobject/src/presentaion/settings/bloc/settings_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerFactory(
      () => SettingsBloc(
        existSettings: sl(),
        loadSettings: sl(),
        saveSettings: sl(),
      ),
    )
    ..registerLazySingleton(() => ExistSettings(sl()))
    ..registerLazySingleton(() => LoadSettings(sl()))
    ..registerLazySingleton(() => SaveSettings(sl()))
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(sl()),
    )
    ..registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImpl(sl()),
    )
    ..registerSingleton<SharedPreferences>(prefs);
}
