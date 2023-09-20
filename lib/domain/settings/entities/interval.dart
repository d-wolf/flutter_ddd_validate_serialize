import 'package:bloc_input_valueobject/domain/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../core/value_object/value_object.dart';

class Interval extends ValueObject<int> {
  static const key = 'interval';

  const Interval._(super.value);

  Interval.value(int value) : this._(_validate(value));
  Interval.empty()
      : this._(left(const IntervalFailureEmpty(message: '', statusCode: '')));

  factory Interval.fromString(String value) {
    final intOrNull = int.tryParse(value);

    if (intOrNull != null) {
      return Interval.value(intOrNull);
    } else {
      return Interval._(
          left(const IntervalFailureParsing(message: '', statusCode: '')));
    }
  }

  static Either<Failure, int> _validate(int value) {
    if (value < 1) {
      return left(const IntervalFailureMinimum(message: '', statusCode: ''));
    } else if (value > 3600) {
      return left(const IntervalFailureMaximum(message: '', statusCode: ''));
    } else {
      return right(value);
    }
  }
}

class IntervalFailureEmpty extends Failure {
  const IntervalFailureEmpty(
      {required super.message, required super.statusCode});
}

class IntervalFailureParsing extends Failure {
  const IntervalFailureParsing(
      {required super.message, required super.statusCode});
}

class IntervalFailureMinimum extends Failure {
  const IntervalFailureMinimum(
      {required super.message, required super.statusCode});
}

class IntervalFailureMaximum extends Failure {
  const IntervalFailureMaximum(
      {required super.message, required super.statusCode});
}
