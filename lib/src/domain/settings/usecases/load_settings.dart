import 'package:bloc_input_valueobject/src/domain/core/typedefs/typedefs.dart';
import 'package:bloc_input_valueobject/src/domain/core/usecase/use_case.dart';
import 'package:bloc_input_valueobject/src/domain/settings/entities/settings.dart';
import 'package:bloc_input_valueobject/src/domain/settings/repositories/settings_repository.dart';

class LoadSettings implements UsecaseWithoutParams<Settings> {
  LoadSettings(this._repository);
  final SettingsRepository _repository;

  @override
  ResultFuture<Settings> call() async {
    return _repository.read();
  }
}
