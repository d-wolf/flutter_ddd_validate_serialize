import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/common_interfaces.dart';
import '../../core/value_object.dart';

part 'interval.freezed.dart';

class Interval extends ValueObject<IntervalFailure, int>
    implements Serializable {
  static const key = 'interval';

  const Interval._(super.value);

  factory Interval(int value) => Interval._(_validate(value));

  factory Interval.empty() => Interval._(left(const IntervalFailure.empty()));

  factory Interval.fromString(String value) {
    final intOrNull = int.tryParse(value);

    if (intOrNull != null) {
      return Interval(intOrNull);
    } else {
      return Interval._(left(const IntervalFailure.isNotInt()));
    }
  }

  factory Interval.fromJson(Map<String, dynamic> map) {
    return Interval.fromString(map[Interval.key].toString());
  }

  @override
  Map<String, String> toJson() {
    return {Interval.key: getOrThrow().toString()};
  }

  static Either<IntervalFailure, int> _validate(int value) {
    if (value < 1) {
      return left(const IntervalFailure.min());
    } else if (value > 3600) {
      return left(const IntervalFailure.max());
    } else {
      return right(value);
    }
  }
}

@freezed
class IntervalFailure with _$IntervalFailure implements Failure {
  const factory IntervalFailure.empty() = _Empty;
  const factory IntervalFailure.min() = _Min;
  const factory IntervalFailure.max() = _Max;
  const factory IntervalFailure.isNotInt() = _IsNotInt;
}
