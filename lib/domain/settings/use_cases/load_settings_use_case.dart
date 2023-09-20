import 'package:bloc_input_valueobject/domain/core/typedefs/typedefs.dart';
import 'package:bloc_input_valueobject/domain/core/usecase/use_case.dart';
import 'package:bloc_input_valueobject/domain/settings/entities/settings.dart';
import 'package:bloc_input_valueobject/domain/settings/repositories/settings_repository.dart';

class LoadSettings implements UsecaseWithoutParams<Settings> {
  final SettingsRepository _repository;

  LoadSettings(this._repository);

  @override
  ResultFuture<Settings> call() async {
    return await _repository.read();
  }
}
