// lib/core/errors/exceptions.dart
class StorageException implements Exception {
  final String message;
  StorageException([this.message = 'Storage exception']);
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Network exception']);
}

class ValidationException implements Exception {
  final String message;
  ValidationException([this.message = 'Validation exception']);
}
