import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String toFormattedString([String? pattern]) {
    return DateFormat(pattern, 'en').format(this);
  }

  String getCommonFormatDate({String pattern = 'yyyy/MM/dd'}) {
    return DateFormat(pattern, 'en').format(this);
  }

  String getTime({String pattern = 'hh:mm a'}) {
    return DateFormat(pattern, 'en').format(this);
  }

  /// used this to show the time with lowercase: 10:00 am
  String getTimeWithLowerCase({String pattern = 'hh:mm a'}) {
    String timeString = DateFormat(pattern, 'en').format(this);
    // return timeString.replaceFirst(
    //   RegExp(r'\s[A|P]M$'),
    //   timeString.substring(timeString.length - 2).toLowerCase(),
    // );
    return timeString.replaceFirstMapped(
      RegExp(r'([AP]M)$'),
      (match) => '${match.group(1)}'.toLowerCase(),
    );
  }

  int toTotalMinutes() {
    return (hour * 60) + minute;
  }
}

extension GetDateTimeByString on String {
  DateTime get getDateTime {
    final dateTime = DateTime.tryParse(this) ?? DateTime.now();
    return dateTime;
  }

  String get getTime {
    return '${DateFormat('hh:mm').format(getDateTime)} ${DateFormat('a').format(getDateTime)}';
  }

  String get getDay {
    return DateFormat('EEE').format(getDateTime);
  }
}
