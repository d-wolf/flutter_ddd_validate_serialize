import 'package:bloc_input_valueobject/domain/core/errors/failures.dart';
import 'package:bloc_input_valueobject/domain/core/value_object/value_object.dart';
import 'package:dartz/dartz.dart';

class Color extends ValueObject<int> {
  static const key = 'color';

  const Color._(super.value);

  Color.value(int value) : this._(_validate(value));
  Color.empty()
      : this._(left(const ColorFailureEmpty(message: '', statusCode: '')));

  factory Color.fromString(String value) {
    final intOrNull = int.tryParse(value);

    if (intOrNull != null) {
      return Color.value(intOrNull);
    } else {
      return Color._(
          left(const ColorFailureParsing(message: '', statusCode: '')));
    }
  }

  static Either<Failure, int> _validate(int value) {
    return right(value);
  }
}

class ColorFailureEmpty extends Failure {
  const ColorFailureEmpty({required super.message, required super.statusCode});
}

class ColorFailureParsing extends Failure {
  const ColorFailureParsing(
      {required super.message, required super.statusCode});
}
