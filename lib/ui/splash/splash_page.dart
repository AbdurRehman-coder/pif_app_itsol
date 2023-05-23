import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';

class SplashPage extends HookWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Timer(const Duration(seconds: 5), _navigateUser);
      return null;
    });
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Center(
          child: Image.asset(
            'assets/ic_logo.png',
            height: 167,
            width: 177,
          ),
        ),
      ],
    );
  }

  void _navigateUser() {
    AppRouter.pushReplacement(Routes.homeScreen);
  }
}
