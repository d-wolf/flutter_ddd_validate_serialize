// import 'package:bloc_input_valueobject/domain/value_objects/interval/interval.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   test('Color.fromString(x) results in ColorFailure.format()', () {
//     expect(Interval.fromString('x').value.fold((l) => l, (r) => null),
//         const IntervalFailure.isNotInt());
//   });

//   test('Interval(0) results in IntervalFailure.min()', () {
//     expect(Interval(0).value.fold((l) => l, (r) => null),
//         const IntervalFailure.min());
//   });

//   test('Interval(3601) results in IntervalFailure.max()', () {
//     expect(Interval(3601).value.fold((l) => l, (r) => null),
//         const IntervalFailure.max());
//   });

//   test('Interval(1) is valid', () {
//     expect(Interval(1).isValid(), isTrue);
//   });
// }
