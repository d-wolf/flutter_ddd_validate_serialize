import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'common_interfaces.dart';

part 'use_case.freezed.dart';

/// Serves as a base class for custom use case implementations.
///
/// This is a modified version of "Fred Grott" (https://github.com/fredgrott)
/// & "Matej Rešetár" (https://github.com/ResoCoder).
abstract interface class UseCase<F extends Failure, R, P> {
  Future<Either<F, R>> call(P params);
}

/// Use if [NoFailure] needs to be returned.
@freezed
class NoFailure with _$NoFailure implements Failure {
  const factory NoFailure() = _NoFailure;
}

/// Use if no [NoParams] are needed.
@freezed
class NoParams with _$NoParams {
  const factory NoParams() = _NoParams;
}

/// Use if [NoResult] needs to be returned.
@freezed
class NoResult with _$NoResult {
  const factory NoResult() = _NoResult;
}
