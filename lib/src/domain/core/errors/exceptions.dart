import 'package:equatable/equatable.dart';

class ValueObjectException extends Equatable implements Exception {
  const ValueObjectException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
