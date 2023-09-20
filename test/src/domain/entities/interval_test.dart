import 'package:bloc_input_valueobject/src/domain/entities/interval.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Interval.empty() results in [TokenFailureEmpty]', () {
    final interval = Interval.empty();
    interval.value.fold(
      (l) => expect(l, isA<IntervalFailureEmpty>()),
      (r) => fail(r.toString()),
    );
  });

  test('Interval.value(0) results in [IntervalFailureMinimum]', () {
    final interval = Interval.value(0);
    interval.value.fold(
      (l) => expect(l, isA<IntervalFailureMinimum>()),
      (r) => fail(r.toString()),
    );
  });

  test('Interval.value(4000) results in [IntervalFailureMaximum]', () {
    final interval = Interval.value(4000);
    interval.value.fold(
      (l) => expect(l, isA<IntervalFailureMaximum>()),
      (r) => fail(r.toString()),
    );
  });

  test('Interval.fromString("a") results in [IntervalFailureParsing]', () {
    final interval = Interval.fromString('a');
    interval.value.fold(
      (l) => expect(l, isA<IntervalFailureParsing>()),
      (r) => fail(r.toString()),
    );
  });

  test('Interval.value(3000) has no failure.', () {
    final interval = Interval.value(3000);
    expect(interval.value, const Right<dynamic, int>(3000));
  });
}
