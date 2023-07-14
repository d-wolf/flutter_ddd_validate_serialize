import '../../../domain/core/use_case.dart';
import '../../../domain/use_cases/load_settings/load_settings_use_case.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/repositories/settings.dart';
import '../../../domain/use_cases/save_settings/save_settings_use_case.dart';
import '../../../domain/value_objects/color/color.dart';
import '../../../domain/value_objects/interval/interval.dart';
import '../../../domain/value_objects/token/token.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.freezed.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  LoadSettingsUseCase loadSettingsUseCase;
  SaveSettingsUseCase saveSettingsUseCase;

  SettingsBloc({
    required this.loadSettingsUseCase,
    required this.saveSettingsUseCase,
  }) : super(const _Loading()) {
    on<_Load>((event, emit) async => await _onLoad(event, emit));
    on<_Save>((event, emit) async => await _onSave(event, emit));
    on<_TokenChanged>((event, emit) => _onTokenChanged(event, emit));
    on<_IntervalChanged>((event, emit) => _onIntervalChanged(event, emit));
    on<_ColorChanged>((event, emit) => _onColorChanged(event, emit));
    on<_SaveHandled>((event, emit) => _onSaveHandled(event, emit));
  }

  Future<void> _onLoad(_Load event, Emitter<SettingsState> emit) async {
    await state.whenOrNull(loading: () async {
      final result = await loadSettingsUseCase(const NoParams());

      result.fold(
          (l) => null,
          (r) => emit(SettingsState.update(
                token: r.token,
                interval: r.interval,
                color: r.color,
                saveRequested: false,
                saveFailure: none(),
              )));
    });
  }

  Future<void> _onSave(_Save event, Emitter<SettingsState> emit) async {
    await state.whenOrNull(
        update: (token, interval, color, saveRequested, saveFailure) async {
      final update = state as _Update;
      emit(const SettingsState.loading());

      final result = await saveSettingsUseCase(SaveSettingsParams(
          settings: Settings(token: token, interval: interval, color: color)));

      result.fold(
          (l) => emit(
              update.copyWith(saveRequested: true, saveFailure: optionOf(l))),
          (r) => emit(update.copyWith(
                saveRequested: true,
                saveFailure: none(),
              )));
    });
  }

  Future<void> _onTokenChanged(
      _TokenChanged event, Emitter<SettingsState> emit) async {
    state.whenOrNull(update: (_, __, ___, ____, _____) {
      emit((state as _Update).copyWith(
        token: Token(event.value),
      ));
    });
  }

  Future<void> _onIntervalChanged(
      _IntervalChanged event, Emitter<SettingsState> emit) async {
    state.whenOrNull(update: (_, __, ___, ____, _____) {
      emit((state as _Update).copyWith(
        interval: Interval.fromString(event.value),
      ));
    });
  }

  Future<void> _onColorChanged(
      _ColorChanged event, Emitter<SettingsState> emit) async {
    state.whenOrNull(update: (_, __, ___, ____, _____) {
      emit((state as _Update).copyWith(
        color: Color(event.value),
      ));
    });
  }

  Future<void> _onSaveHandled(
      _SaveHandled event, Emitter<SettingsState> emit) async {
    state.whenOrNull(update: (_, __, ___, ____, _____) {
      emit((state as _Update).copyWith(
        saveRequested: false,
        saveFailure: none(),
      ));
    });
  }
}
