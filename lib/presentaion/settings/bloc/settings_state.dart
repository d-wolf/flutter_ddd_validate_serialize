part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsStateLoading extends SettingsState {
  const SettingsStateLoading();
}

class SettingsStateUpdate extends SettingsState {
  final Token token;
  final Interval interval;
  final Color color;
  final bool saveRequested;
  final Option<Failure> saveFailure;

  const SettingsStateUpdate({
    required this.token,
    required this.interval,
    required this.color,
    required this.saveRequested,
    required this.saveFailure,
  });

  @override
  List<Object> get props =>
      [token, interval, color, saveRequested, saveFailure];
}
