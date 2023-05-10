import 'dart:ui';

import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;

  bool get isIPhoneX => window.viewPadding.bottom > 0;
}
