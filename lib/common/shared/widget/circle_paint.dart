import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class CirclePaint extends CustomPainter {
  CirclePaint(this.value);

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final area = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width / 2,
    );

    canvas.drawArc(
      area,
      -pi / 2,
      2 * pi * value,
      true,
      Paint()..color = primaryColor.withOpacity(0.2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
