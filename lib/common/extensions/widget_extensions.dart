import 'package:flutter/material.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

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

  Widget shimmerLoading({bool loading = true}) {
    if (!loading) {
      return this;
    }

    return Shimmer.fromColors(
      baseColor: primaryColor,
      highlightColor: Colors.grey[100]!,
      child: this,
    );
  }

  Widget shimmerLoadingSecond({bool loading = true}) {
    if (!loading) {
      return this;
    }

    return Shimmer.fromColors(
      baseColor: primaryColor.withOpacity(0.5),
      highlightColor: Colors.grey[100]!,
      child: this,
    );
  }
}
