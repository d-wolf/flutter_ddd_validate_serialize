import 'package:bloc_input_valueobject/src/data/settings/models/settings_model.dart';
import 'package:bloc_input_valueobject/src/domain/entities/color.dart';
import 'package:bloc_input_valueobject/src/domain/entities/interval.dart';
import 'package:bloc_input_valueobject/src/domain/entities/token.dart';
import 'package:bloc_input_valueobject/src/domain/settings/usecases/exist_settings.dart';
import 'package:bloc_input_valueobject/src/domain/settings/usecases/load_settings.dart';
import 'package:bloc_input_valueobject/src/domain/settings/usecases/save_settings.dart';
import 'package:bloc_input_valueobject/src/presentaion/settings/bloc/settings_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<ExistSettings>(),
  MockSpec<LoadSettings>(),
  MockSpec<SaveSettings>(),
])
import 'settings_bloc_test.mocks.dart';

void main() {
  late MockExistSettings existSettings;
  late MockLoadSettings loadSettings;
  late MockSaveSettings saveSettings;
  late SettingsBloc bloc;

  final tModel = SettingsModel(
    color: Color.value(4294901760),
    token: Token.value('123456789012345678901234567890123456'),
    interval: Interval.value(10),
  );

  setUp(() {
    existSettings = MockExistSettings();
    loadSettings = MockLoadSettings();
    saveSettings = MockSaveSettings();

    bloc = SettingsBloc(
      existSettings: existSettings,
      loadSettings: loadSettings,
      saveSettings: saveSettings,
    );
  });

  test('Initial bloc.state is [SettingsStateLoading].', () async {
    expect(bloc.state, const SettingsStateLoading());
  });

  blocTest<SettingsBloc, SettingsState>(
    'cubit.add(const SettingsEventLoad()) emits [SettingsStateUpdate()] '
    'without failure',
    build: () {
      when(existSettings()).thenAnswer((_) async => right(true));
      when(loadSettings()).thenAnswer((_) async => right(tModel));
      return bloc;
    },
    act: (bloc) => bloc.add(const SettingsEventLoad()),
    expect: () => [
      SettingsStateUpdate(
        token: tModel.token,
        interval: tModel.interval,
        color: tModel.color,
        saveRequested: false,
        saveFailure: none(),
      ),
    ],
  );
}
