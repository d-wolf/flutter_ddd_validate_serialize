import 'package:bloc_input_valueobject/domain/core/errors/exceptions.dart';
import 'package:bloc_input_valueobject/domain/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../common/common_interfaces.dart';

/// Serves as a base class for custom value object implementations.
///
/// This is a modified version of "Fred Grott" (https://github.com/fredgrott)
/// & "Matej Rešetár" (https://github.com/ResoCoder/flutter-tdd-clean-architecture-course).
class ValueObject<T> extends Equatable implements Validatable {
  /// Holds either a failure (left / l) or a valid value (right / r) of type [T].
  ///
  /// Usage:
  /// ```dart
  /// final vo = ValueObject<Failure, String>(right('Hello!'));
  /// vo.value.fold((l) => print(l), (r) => print(r)); // prints "Hello!"
  /// ```
  final Either<Failure, T> value;

  const ValueObject(this.value);

  /// Gets a valid value of type [T] or throws an error.
  T getOrThrow() => value.fold(
      (l) => throw ValueObjectException(message: l.toString()), (r) => r);

  /// Figures out whether [value] is a [Failure] or a valid value.
  @override
  bool isValid() => value.fold((l) => false, (r) => true);

  @override
  List<Object?> get props => [value];
}
