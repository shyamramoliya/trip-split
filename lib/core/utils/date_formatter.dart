// lib/core/utils/date_formatter.dart
import 'package:intl/intl.dart';
import '../extensions/date_extensions.dart';

class DateFormatter {
  static String formatRange(DateTime start, DateTime end) {
    if (start.year == end.year && start.month == end.month) {
      return '${DateFormat('MMM d').format(start)} – ${DateFormat('d, yyyy').format(end)}';
    } else if (start.year == end.year) {
      return '${DateFormat('MMM d').format(start)} – ${DateFormat('MMM d, yyyy').format(end)}';
    }
    return '${DateFormat('MMM d, yyyy').format(start)} – ${DateFormat('MMM d, yyyy').format(end)}';
  }

  static String formatDay(DateTime date) {
    return DateFormat('EEEE, MMM d').format(date);
  }

  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);

    final difference = today.difference(target).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference == -1) return 'Tomorrow';
    if (difference > 1 && difference < 7) return '$difference days ago';
    if (difference < -1 && difference > -7) return 'In ${difference.abs()} days';

    return DateFormat('MMM d').format(date);
  }
}
