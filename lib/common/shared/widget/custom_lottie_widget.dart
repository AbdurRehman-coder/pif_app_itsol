import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLottieWidget extends StatelessWidget {
  const CustomLottieWidget({
    required this.lottieUrl,
    this.isAssets = false,
    super.key,
  });

  final String lottieUrl;
  final bool isAssets;

  @override
  Widget build(BuildContext context) {
    if (!isAssets) {
      return Lottie.network(
        lottieUrl,
        repeat: false,
        reverse: false,
        animate: true,
      );
    } else {
      return Lottie.asset(
        lottieUrl,

      );
    }
  }
}
