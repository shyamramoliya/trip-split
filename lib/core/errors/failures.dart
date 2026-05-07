// lib/core/errors/failures.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class StorageFailure extends Failure {
  const StorageFailure([String message = 'Local storage error occurred']) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network connection failed']) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure([String message = 'Invalid data provided']) : super(message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Requested resource not found']) : super(message);
}
