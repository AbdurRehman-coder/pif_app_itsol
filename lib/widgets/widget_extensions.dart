import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  SafeArea applySafeArea({
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
  }) {
    return SafeArea(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: this,
    );
  }

  Visibility visibility({bool visible = true}) {
    return Visibility(
      visible: visible,
      child: this,
    );
  }

  Center toCenter() {
    return Center(
      child: this,
    );
  }
}
