import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/common_interfaces.dart';
import '../../core/use_case.dart';
import '../../repositories/settings.dart';
import '../../repositories/settings_repository_facade.dart';

part 'save_settings_use_case.freezed.dart';

class SaveSettingsUseCase
    implements UseCase<SaveSettingsFailure, NoResult, SaveSettingsParams> {
  final SettingsRepositoryFacade settingsRepository;

  SaveSettingsUseCase({required this.settingsRepository});

  @override
  Future<Either<SaveSettingsFailure, NoResult>> call(
      SaveSettingsParams params) async {
    try {
      await settingsRepository.write(params.settings);
    } catch (e) {
      return left(const SaveSettingsFailure.unexpected());
    }

    return right(const NoResult());
  }
}

@freezed
class SaveSettingsParams with _$SaveSettingsParams {
  factory SaveSettingsParams({
    required Settings settings,
  }) = _SaveSettingsParams;
}

@freezed
sealed class SaveSettingsFailure with _$SaveSettingsFailure implements Failure {
  const factory SaveSettingsFailure.unexpected() = _Unexpected;
}
