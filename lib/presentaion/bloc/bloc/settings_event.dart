part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.load() = _Load;
  const factory SettingsEvent.tokenChanged({required String value}) =
      _TokenChanged;
  const factory SettingsEvent.intervalChanged({required String value}) =
      _IntervalChanged;
  const factory SettingsEvent.colorChanged({required int value}) =
      _ColorChanged;
  const factory SettingsEvent.save() = _Save;
  const factory SettingsEvent.saveHandled() = _SaveHandled;
}
