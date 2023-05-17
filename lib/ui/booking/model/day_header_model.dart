import 'package:flutter/material.dart';
import 'package:pif_flutter/utils/colors.dart';

class DayHeaderModel {
  DayHeaderModel({
    required this.dayDate,
    required this.dayName,
    required this.isSelected,
    this.isToday,
  });

  String? dayName;
  String? dayDate;
  bool? isSelected;
  bool? isToday;

  double get textFontSize => isToday ?? false ? 8 : 12;

  Color get bgColor => isSelected ?? false ? dateBgColor : Colors.transparent;
}
