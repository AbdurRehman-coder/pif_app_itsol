import 'package:flutter/material.dart';

extension VStateExtension on State {
  VoidCallback get setStateF => () {
        if (mounted) {
          setState(() {});
        }
      };
}
