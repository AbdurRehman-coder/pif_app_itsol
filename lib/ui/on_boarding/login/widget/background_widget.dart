import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.background,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
  }
}
