import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    required this.isLoading,
    required this.child,
    super.key,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return Shimmer.fromColors(
      baseColor: primaryColor,
      highlightColor: Colors.grey[100]!,
      child: widget.child,
    );
  }
}
