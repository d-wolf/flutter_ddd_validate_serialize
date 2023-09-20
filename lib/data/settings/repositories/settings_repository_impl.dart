import 'package:bloc_input_valueobject/data/settings/datasources/settings_local_datasource.dart';
import 'package:bloc_input_valueobject/data/settings/models/settings_model.dart';
import 'package:bloc_input_valueobject/domain/core/errors/failures.dart';
import 'package:bloc_input_valueobject/domain/core/typedefs/typedefs.dart';
import 'package:bloc_input_valueobject/domain/settings/entities/settings.dart';
import 'package:bloc_input_valueobject/domain/settings/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _source;

  SettingsRepositoryImpl(this._source);

  @override
  ResultFuture<void> delete() async {
    try {
      final result = await _source.delete();

      if (!result) {
        throw Exception('An Unexpected Error Occurred');
      }

      return right(null);
    } on Exception catch (e) {
      return left(CacheFailure(message: e.toString(), statusCode: ''));
    }
  }

  @override
  ResultFuture<bool> exists() {
    try {
      final result = _source.exists();
      return Future.value(right(result));
    } on Exception catch (e) {
      return Future.value(
          left(CacheFailure(message: e.toString(), statusCode: '')));
    }
  }

  @override
  ResultFuture<Settings> read() {
    try {
      final result = _source.read();
      return Future.value(right(result));
    } catch (e) {
      return Future.value(
          left(CacheFailure(message: e.toString(), statusCode: '')));
    }
  }

  @override
  ResultFuture<void> write(Settings settings) async {
    try {
      await _source.write(SettingsModel.fromSettings(settings));
      return right(null);
    } catch (e) {
      return left(CacheFailure(message: e.toString(), statusCode: ''));
    }
  }
}
