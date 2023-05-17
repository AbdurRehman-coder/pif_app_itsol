import 'dart:math';

import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    super.key,
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.selectedColor = Colors.white,
    this.unselectedColor = Colors.black12,
  }) : super(listenable: controller!);

  /// The PageController that this DotsIndicator is representing.
  final PageController? controller;

  /// The number of items managed by the PageController
  final int? itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int>? onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color selectedColor;
  final Color unselectedColor;

  // The base size of the dots
  static const double _kDotSize = 5;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2;

  // The distance between the center of each dot
  static const double _kDotSpacing = 10;

  Widget _buildDot(int index) {
    var selectedness = Curves.easeOut.transform(
      max(
        0,
        1.0 - ((controller!.page ?? controller!.initialPage) - index).abs(),
      ),
    );
    final zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 3, right: 3),
        width: (controller!.page ?? controller!.initialPage).round() == index ? _kDotSize + 7 : _kDotSize,
        height: _kDotSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            (controller!.page ?? controller!.initialPage).round() == index ? 10 : _kDotSize / 2,
          ),
          color: (controller!.page ?? controller!.initialPage).round() == index
              ? selectedColor
              : unselectedColor,
        ),
        child: InkWell(
          onTap: () => onPageSelected!(index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount!, _buildDot),
    );
  }
}
