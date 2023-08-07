import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    required this.width,
    required this.height,
    super.key,
    this.borderRadius = BorderRadius.zero,
    this.duration = const Duration(milliseconds: 1500),
  });

  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: duration,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
