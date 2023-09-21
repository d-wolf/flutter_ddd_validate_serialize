import 'package:bloc_input_valueobject/src/domain/core/errors/failures.dart';
import 'package:bloc_input_valueobject/src/domain/core/value_object/value_object.dart';
import 'package:dartz/dartz.dart';

class Color extends ValueObject<ColorFailure, int> {
  Color.empty() : this._(left(const ColorFailureEmpty(message: '')));
  Color.value(int value) : this._(_validate(value));
  const Color._(super.value);

  factory Color.fromString(String value) {
    final intOrNull = int.tryParse(value);

    if (intOrNull != null) {
      return Color.value(intOrNull);
    } else {
      return Color._(left(const ColorFailureParsing(message: '')));
    }
  }

  static Either<ColorFailure, int> _validate(int value) {
    return right(value);
  }
}

sealed class ColorFailure extends Failure {
  const ColorFailure({required super.message});
}

class ColorFailureEmpty extends ColorFailure {
  const ColorFailureEmpty({required super.message});
}

class ColorFailureParsing extends ColorFailure {
  const ColorFailureParsing({required super.message});
}
