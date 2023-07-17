import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/on_boarding/login/provider/login_provider.dart';
import 'package:pinput/pinput.dart';

class PinPutWidget extends StatefulWidget {
  const PinPutWidget({super.key});

  @override
  State<PinPutWidget> createState() => _PinPutWidgetState();
}

class _PinPutWidgetState extends State<PinPutWidget> {
  late Timer timer;
  int startTimers = 60;

  void startTimerFun() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (startTimers == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            startTimers--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimerFun();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: grayTextColor,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    const fillColor = Color.fromRGBO(243, 246, 249, 0);

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final notifier = ref.read(logInProvider.notifier);

        return Column(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                autofocus: true,
                controller: notifier.pinController,
                keyboardType: TextInputType.phone,
                length: 5,
                focusNode: focusNode,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                defaultPinTheme: defaultPinTheme,
                validator: (value) {
                  return value == '22222' ? null : 'Pin is incorrect';
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  setStateF;
                  AppRouter.pushNamed(Routes.welcomeScreen, args: 'Obaida');
                },
                // autofocus: true,
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 9.h),
                      width: 22.w,
                      height: 1.h,
                      color: primaryColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: primaryColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19.r),
                    border: Border.all(color: primaryColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(
                    color: redColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '${S.current.expiredIn} 00:${startTimers.toString().padLeft(2, '0')}',
              style: Style.commonTextStyle(
                color: blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );
      },
    );
  }
}
