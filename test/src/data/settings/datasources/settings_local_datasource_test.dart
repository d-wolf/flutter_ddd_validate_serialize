import 'package:bloc_input_valueobject/src/data/settings/datasources/settings_local_datasource.dart';
import 'package:bloc_input_valueobject/src/data/settings/models/settings_model.dart';
import 'package:bloc_input_valueobject/src/domain/entities/color.dart';
import 'package:bloc_input_valueobject/src/domain/entities/interval.dart';
import 'package:bloc_input_valueobject/src/domain/entities/token.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<SharedPreferences>()])
import 'settings_local_datasource_test.mocks.dart';

void main() {
  late MockSharedPreferences prefs;
  late SettingsLocalDataSourceImpl dataSource;

  final tModel = SettingsModel(
    color: Color.value(4294901760),
    token: Token.value('123456789012345678901234567890123456'),
    interval: Interval.value(10),
  );

  setUp(() {
    prefs = MockSharedPreferences();
    dataSource = SettingsLocalDataSourceImpl(prefs);
  });

  test('SettingsLocalDataSourceImpl.exist returns true.', () {
    when(prefs.containsKey(kLocalDataSourceKey)).thenReturn(true);
    final result = dataSource.exists();
    expect(result, true);
  });

  test('SettingsLocalDataSourceImpl.read returns correct SettingsModel.', () {
    when(prefs.getString(kLocalDataSourceKey))
        .thenReturn(fixture('settings_model.json'));

    final result = dataSource.read();

    expect(
      result,
      tModel,
    );
  });

  test('SettingsLocalDataSourceImpl.write returns true.', () async {
    when(prefs.setString(kLocalDataSourceKey, fixture('settings_model.json')))
        .thenAnswer((_) async => true);

    final result = await dataSource.write(tModel);

    expect(
      result,
      true,
    );
  });

  test('SettingsLocalDataSourceImpl.delete returns true.', () async {
    when(prefs.remove(kLocalDataSourceKey)).thenAnswer((_) async => true);
    final result = await dataSource.delete();
    expect(
      result,
      true,
    );
  });
}
