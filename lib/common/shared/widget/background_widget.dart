import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: context.screenHeight,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.backgorundSecond,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
  }
}
