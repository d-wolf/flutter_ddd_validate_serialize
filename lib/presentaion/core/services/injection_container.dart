import 'package:bloc_input_valueobject/data/settings/datasources/settings_local_datasource.dart';
import 'package:bloc_input_valueobject/data/settings/repositories/settings_repository_impl.dart';
import 'package:bloc_input_valueobject/domain/settings/repositories/settings_repository.dart';
import 'package:bloc_input_valueobject/domain/settings/usecases/exist_settings.dart';
import 'package:bloc_input_valueobject/domain/settings/usecases/load_settings.dart';
import 'package:bloc_input_valueobject/domain/settings/usecases/save_settings.dart';
import 'package:bloc_input_valueobject/presentaion/settings/bloc/settings_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerFactory(() => SettingsBloc(
      existSettings: sl(), loadSettings: sl(), saveSettings: sl()));
  sl.registerLazySingleton(() => ExistSettings(sl()));
  sl.registerLazySingleton(() => LoadSettings(sl()));
  sl.registerLazySingleton(() => SaveSettings(sl()));
  sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(sl()));
  sl.registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImpl(sl()));
  sl.registerSingleton<SharedPreferences>(prefs);
}
