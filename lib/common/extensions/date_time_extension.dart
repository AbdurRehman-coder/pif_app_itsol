import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String toFormattedString([String? pattern]) {
    return DateFormat(pattern, 'en').format(this);
  }

  int toTotalMinutes() {
    return (hour * 60) + minute;
  }
}
