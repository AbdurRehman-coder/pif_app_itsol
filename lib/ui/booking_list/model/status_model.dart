import 'dart:ui';
import 'package:pif_flutter/utils/colors.dart';

class BookingStatusModel {
  BookingStatusModel({required this.name, required this.isSelected});

  String? name;
  bool? isSelected;

  Color? get textColor => isSelected ?? false ? whiteColor : expireStatusColor;

  Color? get bgColor => isSelected ?? false ? primaryColor : grayF5;
}
