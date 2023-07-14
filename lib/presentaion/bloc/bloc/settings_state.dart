part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.loading() = _Loading;

  const factory SettingsState.update({
    required Token token,
    required Interval interval,
    required Color color,
    required bool saveRequested,
    required Option<SaveSettingsFailure> saveFailure,
  }) = _Update;
}
