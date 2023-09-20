import 'package:bloc_input_valueobject/src/data/settings/datasources/settings_local_datasource.dart';
import 'package:bloc_input_valueobject/src/data/settings/models/settings_model.dart';
import 'package:bloc_input_valueobject/src/domain/core/errors/failures.dart';
import 'package:bloc_input_valueobject/src/domain/core/typedefs/typedefs.dart';
import 'package:bloc_input_valueobject/src/domain/settings/entities/settings.dart';
import 'package:bloc_input_valueobject/src/domain/settings/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._source);
  final SettingsLocalDataSource _source;

  @override
  ResultFuture<void> delete() async {
    try {
      final result = await _source.delete();

      if (!result) {
        throw Exception('An Unexpected Error Occurred');
      }

      return right(null);
    } on Exception catch (e) {
      return left(CacheFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<bool> exists() {
    try {
      final result = _source.exists();
      return Future.value(right(result));
    } on Exception catch (e) {
      return Future.value(left(CacheFailure(message: e.toString())));
    }
  }

  @override
  ResultFuture<Settings> read() {
    try {
      final result = _source.read();
      return Future.value(right(result));
    } catch (e) {
      return Future.value(left(CacheFailure(message: e.toString())));
    }
  }

  @override
  ResultFuture<void> write(Settings settings) async {
    try {
      await _source.write(SettingsModel.fromSettings(settings));
      return right(null);
    } catch (e) {
      return left(CacheFailure(message: e.toString()));
    }
  }
}
