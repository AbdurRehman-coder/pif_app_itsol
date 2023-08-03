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
    return timeString.replaceFirstMapped(
      RegExp(r'([AP]M)$'),
      (match) => '${match.group(1)}'.toLowerCase(),
    );
  }

  int toTotalMinutes() {
    return (hour * 60) + minute;
  }

  /// get time passed
  String getTimePassed() {
    final now = DateTime.now();
    final difference = now.difference(this);
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      final format = DateFormat('dd MMM yyyy');
      return format.format(this);
    }
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
