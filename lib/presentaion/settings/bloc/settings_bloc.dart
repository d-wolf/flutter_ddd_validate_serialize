import 'package:bloc_input_valueobject/domain/core/errors/failures.dart';
import 'package:bloc_input_valueobject/domain/settings/entities/color.dart';
import 'package:bloc_input_valueobject/domain/settings/entities/interval.dart';
import 'package:bloc_input_valueobject/domain/settings/entities/settings.dart';
import 'package:bloc_input_valueobject/domain/settings/entities/token.dart';
import 'package:bloc_input_valueobject/domain/settings/usecases/exist_settings.dart';
import 'package:bloc_input_valueobject/domain/settings/usecases/load_settings.dart';
import 'package:bloc_input_valueobject/domain/settings/usecases/save_settings.dart';
import 'package:equatable/equatable.dart';

import 'package:dartz/dartz.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ExistSettings _existSettings;
  final LoadSettings _loadSettings;
  final SaveSettings _saveSettings;

  SettingsBloc({
    required ExistSettings existSettings,
    required LoadSettings loadSettings,
    required SaveSettings saveSettings,
  })  : _existSettings = existSettings,
        _loadSettings = loadSettings,
        _saveSettings = saveSettings,
        super(const SettingsStateLoading()) {
    on<SettingsEventLoad>((event, emit) async => await _onLoad(event, emit));
    on<SettingsEventSave>((event, emit) async => await _onSave(event, emit));
    on<SettingsEventTokenChanged>(
        (event, emit) => _onTokenChanged(event, emit));
    on<SettingsEventIntervalChanged>(
        (event, emit) => _onIntervalChanged(event, emit));
    on<SettingsEventColorChanged>(
        (event, emit) => _onColorChanged(event, emit));
    on<SettingsEventSaveHandled>((event, emit) => _onSaveHandled(event, emit));
  }

  Future<void> _onLoad(
      SettingsEventLoad event, Emitter<SettingsState> emit) async {
    switch (state) {
      case SettingsStateLoading():
        final resultExist = await _existSettings();

        await resultExist.fold((l) => null, (r) async {
          if (r) {
            final result = await _loadSettings();
            result.fold(
                (l) => null,
                (r) async => emit(SettingsStateUpdate(
                      token: r.token,
                      interval: r.interval,
                      color: r.color,
                      saveRequested: false,
                      saveFailure: none(),
                    )));

            return;
          } else {
            emit(SettingsStateUpdate(
              token: Token.empty(),
              interval: Interval.empty(),
              color: Color.empty(),
              saveRequested: false,
              saveFailure: none(),
            ));
          }
        });

        break;
      default:
        break;
    }
  }

  Future<void> _onSave(
      SettingsEventSave event, Emitter<SettingsState> emit) async {
    switch (state) {
      case SettingsStateUpdate update:
        emit(const SettingsStateLoading());

        final result = await _saveSettings(Settings(
            token: update.token,
            interval: update.interval,
            color: update.color));

        result.fold(
            (l) => emit(SettingsStateUpdate(
                token: update.token,
                color: update.color,
                interval: update.interval,
                saveRequested: true,
                saveFailure: optionOf(l))),
            (r) => emit(SettingsStateUpdate(
                token: update.token,
                color: update.color,
                interval: update.interval,
                saveRequested: true,
                saveFailure: none())));
        break;
      default:
        break;
    }
  }

  Future<void> _onTokenChanged(
      SettingsEventTokenChanged event, Emitter<SettingsState> emit) async {
    switch (state) {
      case SettingsStateUpdate update:
        emit(SettingsStateUpdate(
          token: Token.value(event.value),
          interval: update.interval,
          color: update.color,
          saveRequested: update.saveRequested,
          saveFailure: update.saveFailure,
        ));

        break;
      default:
        break;
    }
  }

  Future<void> _onIntervalChanged(
      SettingsEventIntervalChanged event, Emitter<SettingsState> emit) async {
    switch (state) {
      case SettingsStateUpdate update:
        emit(SettingsStateUpdate(
          token: update.token,
          interval: Interval.fromString(event.value),
          color: update.color,
          saveRequested: update.saveRequested,
          saveFailure: update.saveFailure,
        ));

        break;
      default:
        break;
    }
  }

  Future<void> _onColorChanged(
      SettingsEventColorChanged event, Emitter<SettingsState> emit) async {
    switch (state) {
      case SettingsStateUpdate update:
        emit(SettingsStateUpdate(
          token: update.token,
          interval: update.interval,
          color: Color.value(event.value),
          saveRequested: update.saveRequested,
          saveFailure: update.saveFailure,
        ));
        break;
      default:
        break;
    }
  }

  Future<void> _onSaveHandled(
      SettingsEventSaveHandled event, Emitter<SettingsState> emit) async {
    switch (state) {
      case SettingsStateUpdate update:
        emit(SettingsStateUpdate(
          token: update.token,
          interval: update.interval,
          color: update.color,
          saveRequested: false,
          saveFailure: none(),
        ));

        break;
      default:
        break;
    }
  }
}
