import 'package:bloc_input_valueobject/src/domain/core/errors/failures.dart';
import 'package:bloc_input_valueobject/src/domain/core/value_object/value_object.dart';
import 'package:dartz/dartz.dart';

class Interval extends ValueObject<IntervalFailure, int> {
  const Interval._(super.value);

  Interval.value(int value) : this._(_validate(value));
  Interval.empty() : this._(left(const IntervalFailureEmpty(message: '')));

  factory Interval.fromString(String value) {
    final intOrNull = int.tryParse(value);

    if (intOrNull != null) {
      return Interval.value(intOrNull);
    } else {
      return Interval._(left(const IntervalFailureParsing(message: '')));
    }
  }

  static Either<IntervalFailure, int> _validate(int value) {
    if (value < 1) {
      return left(const IntervalFailureMinimum(message: ''));
    } else if (value > 3600) {
      return left(const IntervalFailureMaximum(message: ''));
    } else {
      return right(value);
    }
  }
}

sealed class IntervalFailure extends Failure {
  const IntervalFailure({required super.message});
}

class IntervalFailureEmpty extends IntervalFailure {
  const IntervalFailureEmpty({required super.message});
}

class IntervalFailureParsing extends IntervalFailure {
  const IntervalFailureParsing({required super.message});
}

class IntervalFailureMinimum extends IntervalFailure {
  const IntervalFailureMinimum({required super.message});
}

class IntervalFailureMaximum extends IntervalFailure {
  const IntervalFailureMaximum({required super.message});
}
