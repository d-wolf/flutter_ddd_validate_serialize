import 'package:bloc_input_valueobject/src/domain/core/typedefs/typedefs.dart';
import 'package:bloc_input_valueobject/src/domain/core/usecase/usecase.dart';
import 'package:bloc_input_valueobject/src/domain/settings/entities/settings.dart';
import 'package:bloc_input_valueobject/src/domain/settings/repositories/settings_repository.dart';

class SaveSettings implements UsecaseWithParams<void, Settings> {
  SaveSettings(this._repository);
  final SettingsRepository _repository;

  @override
  ResultFuture<void> call(Settings params) async {
    return _repository.write(params);
  }
}
