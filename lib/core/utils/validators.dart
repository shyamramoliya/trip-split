// lib/core/utils/validators.dart
class Validators {
  static String? tripName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Trip name is required';
    }
    if (value.length < 2 || value.length > 50) {
      return 'Name must be between 2 and 50 characters';
    }
    return null;
  }

  static String? destination(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Destination is required';
    }
    return null;
  }

  static String? dateRange(DateTime? start, DateTime? end) {
    if (start == null || end == null) {
      return 'Both start and end dates are required';
    }
    if (end.isBefore(start)) {
      return 'End date cannot be before start date';
    }
    return null;
  }

  static String? expenseTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required';
    }
    if (value.length < 2 || value.length > 100) {
      return 'Title must be between 2 and 100 characters';
    }
    return null;
  }

  static String? expenseAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required';
    }
    final amount = double.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), ''));
    if (amount == null) {
      return 'Please enter a valid number';
    }
    if (amount <= 0) {
      return 'Amount must be greater than zero';
    }
    return null;
  }

  static String? participantName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2 || value.length > 30) {
      return 'Name must be between 2 and 30 characters';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return null; // Optional
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}
