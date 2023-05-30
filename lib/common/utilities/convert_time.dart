import 'package:intl/intl.dart';

class ConvertTime {
  ConvertTime._();

  static int convertTimeToMinutes({required String time}) {
    final match = RegExp(r'(\d+):(\d+):(\d+)').firstMatch(time);
    final minutes = match == null
        ? 0
        : Duration(
            hours: int.parse(match.group(1)!),
            minutes: int.parse(match.group(2)!),
            seconds: int.parse(match.group(3)!),
          ).inMinutes;
    return minutes;
  }

  static String convertMinutesToTime({required int minutes}) {
    final d = Duration(minutes: minutes);
    final parts = d.toString().split(':');
    final time='${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
    return time;
  }
}
