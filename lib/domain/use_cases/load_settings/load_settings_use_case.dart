import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/common_interfaces.dart';
import '../../core/use_case.dart';
import '../../repositories/settings.dart';
import '../../repositories/settings_repository_facade.dart';
import '../../value_objects/color/color.dart';
import '../../value_objects/interval/interval.dart';
import '../../value_objects/token/token.dart';

part 'load_settings_use_case.freezed.dart';

class LoadSettingsUseCase
    implements UseCase<LoadSettingsFailure, Settings, NoParams> {
  final SettingsRepositoryFacade settingsRepository;

  LoadSettingsUseCase({required this.settingsRepository});

  @override
  Future<Either<LoadSettingsFailure, Settings>> call(NoParams params) async {
    final exists = settingsRepository.exists();

    if (exists) {
      return right(settingsRepository.read());
    } else {
      return right(Settings(
          token: Token.empty(),
          interval: Interval.empty(),
          color: Color.empty()));
    }
  }
}

@freezed
class LoadSettingsFailure with _$LoadSettingsFailure implements Failure {
  const factory LoadSettingsFailure.unexpected() = _Unexpected;
}
