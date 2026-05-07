// lib/core/extensions/double_extensions.dart
import '../utils/currency_formatter.dart';

extension DoubleExtensions on double {
  String toCurrency([String currency = 'INR']) {
    return CurrencyFormatter.format(this, currency: currency);
  }

  String toCompactCurrency([String currency = 'INR']) {
    return CurrencyFormatter.formatCompact(this, currency: currency);
  }
}
