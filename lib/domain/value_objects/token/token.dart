import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/common_interfaces.dart';
import '../../core/value_object.dart';

part 'token.freezed.dart';

class Token extends ValueObject<TokenFailure, String> implements Serializable {
  static const key = 'token';

  const Token._(super.value);

  factory Token(String value) => Token._(_validate(value));

  factory Token.empty() => Token._(left(const TokenFailure.empty()));

  factory Token.fromJson(Map<String, dynamic> map) {
    return Token(map[Token.key].toString());
  }

  @override
  Map<String, String> toJson() {
    return {Token.key: getOrThrow().toString()};
  }

  static Either<TokenFailure, String> _validate(String value) {
    if (value.isEmpty) {
      return left(const TokenFailure.empty());
    } else if (value.length != 36) {
      return left(const TokenFailure.length());
    } else {
      return right(value);
    }
  }
}

@freezed
sealed class TokenFailure with _$TokenFailure implements Failure {
  const factory TokenFailure.length() = Length;
  const factory TokenFailure.empty() = Empty;
}
