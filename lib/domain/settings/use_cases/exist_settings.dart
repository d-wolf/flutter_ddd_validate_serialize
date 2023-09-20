import 'package:bloc_input_valueobject/domain/core/typedefs/typedefs.dart';
import 'package:bloc_input_valueobject/domain/core/usecase/use_case.dart';
import 'package:bloc_input_valueobject/domain/settings/repositories/settings_repository.dart';

class ExistSettings implements UsecaseWithoutParams<bool> {
  final SettingsRepository _repository;

  ExistSettings(this._repository);

  @override
  ResultFuture<bool> call() async {
    return await _repository.exists();
  }
}
