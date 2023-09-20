import 'package:bloc_input_valueobject/src/data/settings/models/settings_model.dart';
import 'package:bloc_input_valueobject/src/domain/entities/color.dart';
import 'package:bloc_input_valueobject/src/domain/entities/interval.dart';
import 'package:bloc_input_valueobject/src/domain/entities/token.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  setUp(() {});

  test('description', () {
    final json = fixture('settings_model.json');
    final model = SettingsModel.fromJson(json);
    expect(
        model,
        SettingsModel(
            color: Color.value(4294901760),
            token: Token.value('123456789012345678901234567890123456'),
            interval: Interval.value(10)));
  });
}
