import 'package:bloc_input_valueobject/src/domain/core/typedefs/typedefs.dart';
import 'package:bloc_input_valueobject/src/domain/core/usecase/use_case.dart';
import 'package:bloc_input_valueobject/src/domain/settings/entities/settings.dart';
import 'package:bloc_input_valueobject/src/domain/settings/repositories/settings_repository.dart';

class SaveSettings implements UsecaseWithParams<void, Settings> {
  final SettingsRepository _repository;

  SaveSettings(this._repository);

  @override
  ResultFuture<void> call(Settings params) async {
    return await _repository.write(params);
  }
}
