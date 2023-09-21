import 'package:bloc_input_valueobject/src/domain/core/errors/failures.dart';
import 'package:bloc_input_valueobject/src/domain/core/value_object/value_object.dart';
import 'package:dartz/dartz.dart';

class Token extends ValueObject<TokenFailure, String> {
  const Token._(super.value);

  Token.value(String value) : this._(_validate(value));
  Token.empty() : this._(left(const TokenFailureEmpty(message: '')));

  static Either<TokenFailure, String> _validate(String value) {
    if (value.isEmpty) {
      return left(const TokenFailureEmpty(message: ''));
    } else if (value.length != 36) {
      return left(const TokenFailureMinimumMaximum(message: ''));
    } else {
      return right(value);
    }
  }
}

sealed class TokenFailure extends Failure {
  const TokenFailure({required super.message});
}

class TokenFailureEmpty extends TokenFailure {
  const TokenFailureEmpty({required super.message});
}

class TokenFailureMinimumMaximum extends TokenFailure {
  const TokenFailureMinimumMaximum({required super.message});
}
