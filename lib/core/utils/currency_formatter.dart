// lib/core/utils/currency_formatter.dart
import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(double amount, {String currency = 'INR'}) {
    final format = NumberFormat.currency(
      symbol: _getCurrencySymbol(currency),
      decimalDigits: 2,
    );
    return format.format(amount);
  }

  static String formatCompact(double amount, {String currency = 'INR'}) {
    final format = NumberFormat.compactCurrency(
      symbol: _getCurrencySymbol(currency),
      decimalDigits: 1,
    );
    return format.format(amount);
  }

  static String _getCurrencySymbol(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'USD': return '\$';
      case 'EUR': return '€';
      case 'GBP': return '£';
      case 'INR': return '₹';
      case 'AUD': return 'A\$';
      case 'CAD': return 'C\$';
      default: return '$currencyCode ';
    }
  }
}
