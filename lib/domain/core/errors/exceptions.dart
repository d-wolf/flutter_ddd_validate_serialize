import 'package:equatable/equatable.dart';

class CacheException extends Equatable implements Exception {
  const CacheException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class ValueObjectException extends Equatable implements Exception {
  const ValueObjectException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
