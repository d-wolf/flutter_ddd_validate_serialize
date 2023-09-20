import 'package:bloc_input_valueobject/src/domain/entities/token.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Token.empty() results in [TokenFailureEmpty]', () {
    final token = Token.empty();
    token.value
        .fold((l) => expect(l, isA<TokenFailureEmpty>()), (r) => fail(r));
  });

  test('Token.value("") results in [TokenFailureMinimumMaximum]', () {
    final token = Token.value('123456');
    token.value.fold(
        (l) => expect(l, isA<TokenFailureMinimumMaximum>()), (r) => fail(r));
  });

  test('Token has no failure.', () {
    final token = Token.value('f39f6740-8801-4356-94f7-9e7be03ac273');
    expect(token.value, right('f39f6740-8801-4356-94f7-9e7be03ac273'));
  });
}
