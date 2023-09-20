import 'package:bloc_input_valueobject/src/data/settings/datasources/settings_local_datasource.dart';
import 'package:bloc_input_valueobject/src/data/settings/models/settings_model.dart';
import 'package:bloc_input_valueobject/src/data/settings/repositories/settings_repository_impl.dart';
import 'package:bloc_input_valueobject/src/domain/core/errors/failures.dart';
import 'package:bloc_input_valueobject/src/domain/entities/color.dart';
import 'package:bloc_input_valueobject/src/domain/entities/interval.dart';
import 'package:bloc_input_valueobject/src/domain/entities/token.dart';
import 'package:bloc_input_valueobject/src/domain/settings/entities/settings.dart';
import 'package:bloc_input_valueobject/src/domain/settings/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<SettingsLocalDataSource>()])
import 'settings_repository_impl_test.mocks.dart';

void main() {
  late MockSettingsLocalDataSource dataSource;
  late SettingsRepository repository;

  final tModel = SettingsModel(
    color: Color.value(4294901760),
    token: Token.value('123456789012345678901234567890123456'),
    interval: Interval.value(10),
  );

  setUp(() {
    dataSource = MockSettingsLocalDataSource();
    repository = SettingsRepositoryImpl(dataSource);
  });

  test('repository.delete returns success.', () async {
    when(dataSource.delete()).thenAnswer((_) async => true);
    final result = await repository.delete();
    expect(result, const Right<dynamic, void>(null));
  });

  test('repository.delete returns failure.', () async {
    when(dataSource.delete()).thenAnswer((_) async => false);
    final result = await repository.delete();
    result.fold((l) => expect(l, isA<CacheFailure>()), (r) => fail(''));
  });

  test('repository.exists returns true.', () async {
    when(dataSource.exists()).thenReturn(true);
    final result = await repository.exists();
    expect(result, const Right<dynamic, bool>(true));
  });

  test('repository.read returns model successfully.', () async {
    when(dataSource.read()).thenReturn(tModel);

    final result = await repository.read();

    expect(
      result,
      Right<dynamic, Settings>(tModel),
    );
  });

  test('repository.write success.', () async {
    when(dataSource.write(tModel)).thenAnswer((_) async => true);

    final result = await repository.write(tModel);

    expect(
      result,
      const Right<dynamic, void>(null),
    );
  });

  test('repository.write failure.', () async {
    when(dataSource.write(tModel)).thenAnswer((_) async => false);

    final result = await repository.write(tModel);

    result.fold((l) => expect(l, isA<CacheFailure>()), (r) => fail(''));
  });
}
