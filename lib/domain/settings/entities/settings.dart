import 'package:equatable/equatable.dart';

import 'color.dart';
import 'interval.dart';
import 'token.dart';

class Settings extends Equatable {
  final Token token;
  final Interval interval;
  final Color color;

  const Settings({
    required this.token,
    required this.interval,
    required this.color,
  });

  @override
  List<Object?> get props => [token, interval, color];
}
