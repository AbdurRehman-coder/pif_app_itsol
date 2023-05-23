import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContextExt on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;

  bool get isIPhoneX => View.of(this).viewPadding.bottom > 0;

  bool get isDynamicIsland => statusBarHeight > 47;

  double get dynamicIslandSpacing => isDynamicIsland ? 12.h : 0;

  double get topHeaderHeight => Platform.isIOS ? 230.h + dynamicIslandSpacing : 190.h;

  double get containerTopMargin => Platform.isIOS ? 210.h - (isDynamicIsland ? 0 : 10.h) : 165.h;
}
