import 'dart:async';

import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pif_flutter/common/index.dart';
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
    return Scaffold(
      body: Stack(
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
      ),
    );
  }

  Future<void> _navigateUser() async {
    final data = await DixelsSDK.instance.userDetails;
    if (data != null) {
      await AppRouter.pushReplacement(Routes.dashboardScreen);
    } else {
      await AppRouter.pushReplacement(Routes.logInScreen);
    }
  }
}
