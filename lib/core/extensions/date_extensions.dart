// lib/core/extensions/date_extensions.dart
import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String toFormattedString([String format = 'MMM dd, yyyy']) {
    return DateFormat(format).format(this);
  }
}
