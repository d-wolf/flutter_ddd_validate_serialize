part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsEventLoad extends SettingsEvent {
  const SettingsEventLoad();

  @override
  List<Object?> get props => [];
}

class SettingsEventTokenChanged extends SettingsEvent {
  const SettingsEventTokenChanged({required this.value});

  final String value;

  @override
  List<Object?> get props => [value];
}

class SettingsEventIntervalChanged extends SettingsEvent {
  const SettingsEventIntervalChanged({required this.value});

  final String value;

  @override
  List<Object?> get props => [value];
}

class SettingsEventColorChanged extends SettingsEvent {
  const SettingsEventColorChanged({required this.value});

  final int value;

  @override
  List<Object?> get props => [value];
}

class SettingsEventSave extends SettingsEvent {
  const SettingsEventSave();
}

class SettingsEventSaveHandled extends SettingsEvent {
  const SettingsEventSaveHandled();
}
