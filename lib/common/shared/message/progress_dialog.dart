import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/shared/message/wait_reload.dart';
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
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Container(
              height: 70,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.r),
                ),
              ),
              child: Row(
                children: [
                  const AppWait(),
                  SizedBox(width: kIsWeb ? 20 : 20.w),
                  Text(
                    message,
                    style: TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.none,
                      fontSize: kIsWeb ? 17 : 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
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
