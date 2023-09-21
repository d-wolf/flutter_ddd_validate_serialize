import 'package:bloc_input_valueobject/src/domain/core/typedefs/typedefs.dart';
import 'package:bloc_input_valueobject/src/domain/core/usecase/usecase.dart';
import 'package:bloc_input_valueobject/src/domain/settings/repositories/settings_repository.dart';

class ExistSettings implements UsecaseWithoutParams<bool> {
  ExistSettings(this._repository);
  final SettingsRepository _repository;

  @override
  ResultFuture<bool> call() async {
    return _repository.exists();
  }
}
