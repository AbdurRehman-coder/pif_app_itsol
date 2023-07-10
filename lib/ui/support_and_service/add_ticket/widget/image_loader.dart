import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/circle_paint.dart';

class ImageLoader extends StatefulWidget {
  const ImageLoader({super.key});


  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  double sliderValue = 0;
  Timer? _timer;

  void _initTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        sliderValue += 5;
      });
      if (sliderValue == 100) {
        _timer?.cancel();
      }
    });
  }

  @override
  void initState() {
    _initTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 15.h,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 3,
                thumbColor: Colors.transparent,
                disabledActiveTrackColor: primaryColor,
                disabledInactiveTrackColor: inactiveTrackColor,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 0,
                ),
              ),
              child: Slider(
                value: sliderValue,
                max: 100,
                onChanged: null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
