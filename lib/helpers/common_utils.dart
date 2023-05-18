import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/ui/booking/model/day_header_model.dart';

class CommonUtils {
  static DateTime? _lastToastTime;

  static void showToast({required String message}) {
    if (_lastToastTime == null ||
        DateTime.now().difference(_lastToastTime!) > const Duration(seconds: 1, milliseconds: 200)) {
      _lastToastTime = DateTime.now();
      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
    }
  }

  static List<DayHeaderModel> getNextSevenDays() {
    final daysList = <DayHeaderModel>[];
    final today = DateTime.now();
    final formatter = DateFormat('EEEE');

    daysList.add(
      DayHeaderModel(dayDate: today.day.toString(), dayName: 'Today', isSelected: true, isToday: true),
    );
    for (var i = 1; i < 7; i++) {
      final dayDate = today.add(Duration(days: i));
      final dayName = formatter.format(dayDate).substring(0, 1);
      daysList.add(DayHeaderModel(dayDate: dayDate.day.toString(), dayName: dayName, isSelected: false));
    }
    return daysList;
  }

  static List<DayHeaderModel> getNextThirtyDays() {
    final daysList = <DayHeaderModel>[];
    final today = DateTime.now();
    final formatter = DateFormat('EEEE');

    daysList.add(
      DayHeaderModel(dayDate: today.day.toString(), dayName: 'Today', isSelected: true, isToday: true),
    );
    for (var i = 1; i < 30; i++) {
      final dayDate = today.add(Duration(days: i));
      final dayName = formatter.format(dayDate).substring(0, 1);
      daysList.add(DayHeaderModel(dayDate: dayDate.day.toString(), dayName: dayName, isSelected: false));
    }
    return daysList;
  }
}
