import 'package:bloc_input_valueobject/domain/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../core/value_object/value_object.dart';

class Token extends ValueObject<String> {
  static const key = 'token';

  const Token._(super.value);

  Token.value(String value) : this._(_validate(value));
  Token.empty()
      : this._(left(const ValidationFailure(message: '', statusCode: '')));

  static Either<Failure, String> _validate(String value) {
    if (value.isEmpty) {
      return left(const ValidationFailure(message: '', statusCode: ''));
    } else if (value.length != 36) {
      return left(const ValidationFailure(message: '', statusCode: ''));
    } else {
      return right(value);
    }
  }
}
