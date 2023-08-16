import 'dart:async';

import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/banner_video_view.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/routes/routes.dart';

class SplashPage extends HookWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Timer(
        const Duration(seconds: 4),
        _navigateUser,
      );
      return null;
    });
    return Scaffold(
      body: BannerVideoView(
        videoUrl:
            '${Constants.baseUrl}/documents/20120/147621/v1.mp4/?videoPreview=1&type=mp4',
        hideChangeAudio: true,
      ),
    );
  }

  Future<void> _navigateUser() async {
    final data = await DixelsSDK.instance.userDetails;
    if (data != null) {
      if (data.customFields
              ?.where((element) => element.name == 'isVerified')
              .firstOrNull
              ?.customValue
              .data
              .toString()
              .toLowerCase() ==
          'true') {
        await AppRouter.startNewRoute(
          Routes.dashboardScreen,
        );
      } else {
        await AppRouter.pushReplacement(
          Routes.welcomeScreen,
          args: data.givenName,
        );
      }
    } else {
      await AppRouter.pushReplacement(Routes.logInScreen);
    }
  }
}
