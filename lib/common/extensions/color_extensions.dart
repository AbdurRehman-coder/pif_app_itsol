import 'package:flutter/material.dart';

extension ColorExtensions on String {
  Color get hexToColor {
    return Color(int.parse(substring(1, 7), radix: 16) + 0xFF000000);
  }
}
