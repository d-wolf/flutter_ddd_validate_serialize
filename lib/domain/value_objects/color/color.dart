import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/common_interfaces.dart';
import '../../core/value_object.dart';

part 'color.freezed.dart';

class Color extends ValueObject<ColorFailure, int> implements Serializable {
  static const key = 'color';

  const Color._(super.value);

  factory Color(int value) => Color._(_validate(value));

  factory Color.empty() => Color._(left(const ColorFailure.empty()));

  factory Color.fromString(String value) {
    final intOrNull = int.tryParse(value);

    if (intOrNull != null) {
      return Color(intOrNull);
    } else {
      return Color._(left(const ColorFailure.format()));
    }
  }

  static Either<ColorFailure, int> _validate(int value) {
    return right(value);
  }

  factory Color.fromJson(Map<String, dynamic> map) {
    return Color.fromString(map[Color.key].toString());
  }

  @override
  Map<String, String> toJson() {
    return {Color.key: getOrThrow().toString()};
  }
}

@freezed
sealed class ColorFailure with _$ColorFailure implements Failure {
  const factory ColorFailure.empty() = Empty;
  const factory ColorFailure.format() = Format;
}
