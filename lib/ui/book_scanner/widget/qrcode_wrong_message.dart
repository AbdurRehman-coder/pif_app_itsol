import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';

class QRCodeWrongMessage extends StatefulWidget {
  const QRCodeWrongMessage({super.key});

  @override
  State<QRCodeWrongMessage> createState() => _QRCodeWrongMessageState();
}

class _QRCodeWrongMessageState extends State<QRCodeWrongMessage> {
  late Timer timer;
  int start = 3;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 35.h,
        horizontal: 20.w,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.qrcode,
              width: 150.w,
              height: 150.h,
            ),
            SizedBox(height: 30.h),
            Center(
              child: Text(
                S.of(context).pleaseMakeSureYouAreScanningAValidRoomQRCode,
                style: Style.commonTextStyle(
                  color: redColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 100.h,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 50.w,
                      height: 50.h,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                  Center(
                    child: Text(
                      start.toString(),
                      style: Style.commonTextStyle(
                        color: primaryColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
