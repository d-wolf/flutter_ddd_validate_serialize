import 'package:bloc_input_valueobject/src/domain/core/errors/exceptions.dart';
import 'package:bloc_input_valueobject/src/domain/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ValueObject<T> extends Equatable {
  const ValueObject(this.value);

  /// Holds either a failure (left / l) or a valid value (right / r) of type [T].
  ///
  /// Usage:
  /// ```dart
  /// final v = ValueObject<Failure, String>(right('Hello!'));
  /// v.value.fold((l) => print(l), (r) => print(r)); // prints "Hello!"
  /// ```
  final Either<Failure, T> value;

  /// Gets a valid value of type [T] or throws an [ValueObjectException].
  T getOrThrow() => value.fold(
        (l) => throw ValueObjectException(message: l.toString()),
        (r) => r,
      );

  /// Figures out whether [value] is a [Failure] or a valid value.
  bool isValid() => value.fold((l) => false, (r) => true);

  @override
  List<Object?> get props => [value];
}
