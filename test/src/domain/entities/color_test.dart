import 'package:bloc_input_valueobject/src/domain/entities/color.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Color.empty() results in [TokenFailureEmpty]', () {
    final color = Color.empty();
    color.value.fold(
        (l) => expect(l, isA<ColorFailureEmpty>()), (r) => fail(r.toString()));
  });

  test('Color.fromString("a") results in [TokenFailureEmpty]', () {
    final color = Color.fromString('a');
    color.value.fold((l) => expect(l, isA<ColorFailureParsing>()),
        (r) => fail(r.toString()));
  });

  test('Interval.value(0) results in [IntervalFailureMinimum]', () {
    final color = Color.value(0xFFFFFFFF);
    expect(color.value, right(0xFFFFFFFF));
  });
}
