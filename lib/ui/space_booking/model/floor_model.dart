import 'package:flutter/material.dart';
import 'package:pif_flutter/utils/colors.dart';

class FloorModel {
  FloorModel({required this.floorId, required this.floorName, required this.isSelected});

  String? floorId;
  String? floorName;
  bool? isSelected;

  Color? get borderColor => isSelected ?? false ? Colors.transparent : darkBorderColor;
  Color? get backgroundColor => isSelected ?? false ? primaryColor : whiteColor;
  Color? get textColor => isSelected ?? false ? whiteColor : darkBorderColor;
}
