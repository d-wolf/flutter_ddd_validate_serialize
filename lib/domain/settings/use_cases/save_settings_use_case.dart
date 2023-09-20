import 'package:bloc_input_valueobject/domain/core/typedefs/typedefs.dart';
import 'package:bloc_input_valueobject/domain/core/usecase/use_case.dart';
import 'package:bloc_input_valueobject/domain/settings/entities/settings.dart';
import 'package:bloc_input_valueobject/domain/settings/repositories/settings_repository.dart';

class SaveSettings implements UsecaseWithParams<void, Settings> {
  final SettingsRepository _repository;

  SaveSettings(this._repository);

  @override
  ResultFuture<void> call(Settings params) async {
    return await _repository.write(params);
  }
}
