import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/wait_reload.dart';
import 'package:pif_flutter/common/shared/widget/custom_lottie_widget.dart';
import 'package:pif_flutter/utils/colors.dart';

class AppProgressDialog {
  AppProgressDialog({
    required this.context,
    String? message,
  }) : message = message ?? 'Please wait..';
  final BuildContext context;

  final String message;

  Future<void> start() async {
    // ignore: unawaited_futures
    showDialog<dynamic>(
      barrierDismissible: false,
      context: context,
      builder: (c) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: const Center(
            child: CustomLottieWidget(
              lottieUrl: Assets.loaderLottie,
              isAssets: true,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> stop() async {
    Navigator.of(context).pop();
  }
}
