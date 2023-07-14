import 'package:bloc_input_valueobject/domain/value_objects/token/token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Token(' ') results in TokenFailure.empty()', () {
    expect(
        Token('').value.fold((l) => l, (r) => r), const TokenFailure.empty());
  });

  test('Token("x") results in TokenFailure.length()', () {
    expect(
        Token('x').value.fold((l) => l, (r) => r), const TokenFailure.length());
  });

  test(
      'Token("f39f6740-8801-4356-94f7-9e7be03ac273m") results in TokenFailure.length()',
      () {
    expect(
        Token('f39f6740-8801-4356-94f7-9e7be03ac273m')
            .value
            .fold((l) => l, (r) => r),
        const TokenFailure.length());
  });

  test('Token("f39f6740-8801-4356-94f7-9e7be03ac273") results in valid value',
      () {
    expect(Token('f39f6740-8801-4356-94f7-9e7be03ac273').isValid(), isTrue);
  });
}
