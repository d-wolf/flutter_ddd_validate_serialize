import 'package:bloc_input_valueobject/domain/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../core/common/common_interfaces.dart';
import '../../core/value_object/value_object.dart';

class Interval extends ValueObject<int> {
  static const key = 'interval';

  const Interval._(super.value);

  Interval.value(int value) : this._(_validate(value));
  Interval.empty()
      : this._(left(const ValidationFailure(message: '', statusCode: '')));

  factory Interval.fromString(String value) {
    final intOrNull = int.tryParse(value);

    if (intOrNull != null) {
      return Interval.value(intOrNull);
    } else {
      return Interval._(
          left(const ValidationFailure(message: '', statusCode: '')));
    }
  }

  static Either<Failure, int> _validate(int value) {
    if (value < 1) {
      return left(const ValidationFailure(message: '', statusCode: ''));
    } else if (value > 3600) {
      return left(const ValidationFailure(message: '', statusCode: ''));
    } else {
      return right(value);
    }
  }
}
