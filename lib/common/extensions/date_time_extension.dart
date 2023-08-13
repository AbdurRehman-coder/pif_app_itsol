import 'package:intl/intl.dart';
import 'package:pif_flutter/common/index.dart';

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
    final timeString = DateFormat(pattern, 'en').format(this);
    return timeString.replaceFirstMapped(
      RegExp(r'([AP]M)$'),
      (match) => '${match.group(1)}'.toLowerCase(),
    );
  }

  int toTotalMinutes() {
    return (hour * 60) + minute;
  }

  bool get isBeforeNow {
    return isBefore(DateTime.now());
  }

  bool get isAfterNow {
    return isAfter(DateTime.now());
  }

  ///Calculate different between two days
  String get daysBetween {
    final different = DateTime.now().difference(this);
    if ((different.inDays) > 0) {
      return '${different.inDays} ${S.current.days}';
    } else if ((different.inHours) > 0) {
      return '${((different.inHours) / 24).round()} ${S.current.hours}';
    } else {
      return '${different.inMinutes} ${S.current.minutes}';
    }
  }

  /// get time passed
  String get getTimePassed {
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
