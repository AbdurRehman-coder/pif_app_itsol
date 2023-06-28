import 'dart:io';

import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;

  bool get isIPhoneX => View.of(this).viewPadding.bottom > 0;

  bool get isDynamicIsland => statusBarHeight > 47;

  double get dynamicIslandSpacing => isDynamicIsland ? 12 : 0;

  double get topHeaderHeight => Platform.isIOS ? 230 + dynamicIslandSpacing : 190;

  double get containerTopMargin => Platform.isIOS ? 210 - (isDynamicIsland ? 0 : 10) : 165;
}
