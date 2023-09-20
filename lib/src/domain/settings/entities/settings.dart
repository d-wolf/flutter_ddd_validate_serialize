import 'package:bloc_input_valueobject/src/domain/entities/color.dart';
import 'package:bloc_input_valueobject/src/domain/entities/interval.dart';
import 'package:bloc_input_valueobject/src/domain/entities/token.dart';
import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  const Settings({
    required this.token,
    required this.interval,
    required this.color,
  });
  final Token token;
  final Interval interval;
  final Color color;

  @override
  List<Object?> get props => [token, interval, color];
}
