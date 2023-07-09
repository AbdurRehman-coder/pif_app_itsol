import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    super.key,
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.kDotSize = 5,
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
  final double kDotSize;

  Widget _buildDot(int index) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 3, right: 3),
        width: (controller!.page ?? controller!.initialPage).round() == index ? kDotSize + 7 : kDotSize,
        height: kDotSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            (controller!.page ?? controller!.initialPage).round() == index ? 10 : kDotSize / 2,
          ),
          color: (controller!.page ?? controller!.initialPage).round() == index ? selectedColor : unselectedColor,
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
