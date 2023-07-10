import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pif_flutter/common/shared/widget/circle_paint.dart';

class ImageLoader extends StatefulWidget {
  const ImageLoader({super.key});


  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  double sliderValue = 0.0;
  Timer? _timer;

  void _initTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        sliderValue += 0.05;
      });
      if (sliderValue > 1.0) {
        _timer?.cancel();
      }
    });
  }

  @override
  void initState() {
    _initTimer();
    super.initState();
  }

  double value = .4;
  final size = 50.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: CustomPaint(
        painter: CirclePaint(sliderValue),
      ),
    );
  }
}
