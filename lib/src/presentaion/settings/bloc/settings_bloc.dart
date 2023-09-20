import 'package:bloc_input_valueobject/src/domain/core/errors/failures.dart';
import 'package:bloc_input_valueobject/src/domain/entities/color.dart';
import 'package:bloc_input_valueobject/src/domain/entities/interval.dart';
import 'package:bloc_input_valueobject/src/domain/entities/token.dart';
import 'package:bloc_input_valueobject/src/domain/settings/entities/settings.dart';
import 'package:bloc_input_valueobject/src/domain/settings/usecases/exist_settings.dart';
import 'package:bloc_input_valueobject/src/domain/settings/usecases/load_settings.dart';
import 'package:bloc_input_valueobject/src/domain/settings/usecases/save_settings.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required ExistSettings existSettings,
    required LoadSettings loadSettings,
    required SaveSettings saveSettings,
  })  : _existSettings = existSettings,
        _loadSettings = loadSettings,
        _saveSettings = saveSettings,
        super(const SettingsStateLoading()) {
    on<SettingsEventLoad>((event, emit) async => _onLoad(event, emit));
    on<SettingsEventSave>((event, emit) async => _onSave(event, emit));
    on<SettingsEventTokenChanged>(
      _onTokenChanged,
    );
    on<SettingsEventIntervalChanged>(
      _onIntervalChanged,
    );
    on<SettingsEventColorChanged>(_onColorChanged);
    on<SettingsEventSaveHandled>(_onSaveHandled);
  }
  final ExistSettings _existSettings;
  final LoadSettings _loadSettings;
  final SaveSettings _saveSettings;

  Future<void> _onLoad(
    SettingsEventLoad event,
    Emitter<SettingsState> emit,
  ) async {
    switch (state) {
      case SettingsStateLoading():
        final resultExist = await _existSettings();

        await resultExist.fold((l) => null, (r) async {
          if (r) {
            final result = await _loadSettings();
            result.fold(
              (l) => null,
              (r) => emit(
                SettingsStateUpdate(
                  token: r.token,
                  interval: r.interval,
                  color: r.color,
                  saveRequested: false,
                  saveFailure: none(),
                ),
              ),
            );

            return;
          } else {
            emit(
              SettingsStateUpdate(
                token: Token.empty(),
                interval: Interval.empty(),
                color: Color.empty(),
                saveRequested: false,
                saveFailure: none(),
              ),
            );
          }
        });

      default:
        break;
    }
  }

  Future<void> _onSave(
    SettingsEventSave event,
    Emitter<SettingsState> emit,
  ) async {
    switch (state) {
      case final SettingsStateUpdate update:
        emit(const SettingsStateLoading());

        final result = await _saveSettings(
          Settings(
            token: update.token,
            interval: update.interval,
            color: update.color,
          ),
        );

        result.fold(
          (l) => emit(
            SettingsStateUpdate(
              token: update.token,
              color: update.color,
              interval: update.interval,
              saveRequested: true,
              saveFailure: optionOf(l),
            ),
          ),
          (r) => emit(
            SettingsStateUpdate(
              token: update.token,
              color: update.color,
              interval: update.interval,
              saveRequested: true,
              saveFailure: none(),
            ),
          ),
        );
      default:
        break;
    }
  }

  Future<void> _onTokenChanged(
    SettingsEventTokenChanged event,
    Emitter<SettingsState> emit,
  ) async {
    switch (state) {
      case final SettingsStateUpdate update:
        emit(
          SettingsStateUpdate(
            token: Token.value(event.value),
            interval: update.interval,
            color: update.color,
            saveRequested: update.saveRequested,
            saveFailure: update.saveFailure,
          ),
        );

      default:
        break;
    }
  }

  Future<void> _onIntervalChanged(
    SettingsEventIntervalChanged event,
    Emitter<SettingsState> emit,
  ) async {
    switch (state) {
      case final SettingsStateUpdate update:
        emit(
          SettingsStateUpdate(
            token: update.token,
            interval: Interval.fromString(event.value),
            color: update.color,
            saveRequested: update.saveRequested,
            saveFailure: update.saveFailure,
          ),
        );

      default:
        break;
    }
  }

  Future<void> _onColorChanged(
    SettingsEventColorChanged event,
    Emitter<SettingsState> emit,
  ) async {
    switch (state) {
      case final SettingsStateUpdate update:
        emit(
          SettingsStateUpdate(
            token: update.token,
            interval: update.interval,
            color: Color.value(event.value),
            saveRequested: update.saveRequested,
            saveFailure: update.saveFailure,
          ),
        );
      default:
        break;
    }
  }

  Future<void> _onSaveHandled(
    SettingsEventSaveHandled event,
    Emitter<SettingsState> emit,
  ) async {
    switch (state) {
      case final SettingsStateUpdate update:
        emit(
          SettingsStateUpdate(
            token: update.token,
            interval: update.interval,
            color: update.color,
            saveRequested: false,
            saveFailure: none(),
          ),
        );

      default:
        break;
    }
  }
}
