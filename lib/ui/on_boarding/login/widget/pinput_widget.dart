import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/on_boarding/login/provider/login_provider.dart';
import 'package:pif_flutter/ui/on_boarding/login/state/login_state.dart';
import 'package:pinput/pinput.dart';

class PinPutWidget extends ConsumerStatefulWidget {
  const PinPutWidget({
    required this.notifier,
    required this.provider,
    super.key,
  });

  final LogInNotifier notifier;
  final LogInState provider;

  @override
  ConsumerState createState() => _PinPutWidgetState();
}

class _PinPutWidgetState extends ConsumerState<PinPutWidget> {
  late Timer timer;

  late int startTimers;

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
    startTimers = widget.provider.expiryTime ?? 30;
    startTimerFun();
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = primaryColor;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: Pinput(
            autofocus: true,
            length: widget.provider.otpLength ?? 5,
            keyboardType: TextInputType.phone,
            defaultPinTheme: defaultPinTheme,
            onCompleted: (pin) => widget.notifier.verifyOTP(
              otpCode: pin,
              context: context,
            ),
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  width: 22,
                  height: 1,
                  color: primaryColor,
                ),
              ],
            ),
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: primaryColor),
              ),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                color: fillColor,
                borderRadius: BorderRadius.circular(19),
                border: Border.all(color: primaryColor),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyBorderWith(
              border: Border.all(color: Colors.redAccent),
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
        SizedBox(height: 20.h),
        Wrap(
          children: [
            Text(
              S.current.receiveAnEmail,
              style: TextStyle(
                color: dayTextColor,
                fontSize: 14.sp,
              ),
            ),
            InkWell(
              onTap: startTimers == 0
                  ? () {
                      widget.notifier.createLogIn(
                        context: context,
                        notifier: widget.notifier,
                        isResendOTP: true,
                      );
                      setState(() {
                        startTimers = widget.provider.expiryTime ?? 30;
                      });
                      startTimerFun();
                    }
                  : null,
              child: Text(
                S.current.resendEmail,
                style: TextStyle(
                  color: startTimers == 0 ? primaryColor : lightGoldenColor,
                  fontSize: 14.sp,
                  fontWeight:
                      startTimers == 0 ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
