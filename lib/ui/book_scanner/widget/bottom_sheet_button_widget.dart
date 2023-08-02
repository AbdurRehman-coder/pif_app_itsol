import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class BottomSheetButtonWidget extends StatelessWidget {
  const BottomSheetButtonWidget({
    required this.onTap,
    super.key,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: whiteColor.withOpacity(0.70),
        ),
        height: 80.h,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: S.of(context).troubleScanningQRCode,
                    style: Style.commonTextStyle(
                      color: textColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: S.of(context).searchSpaces,
                    recognizer: TapGestureRecognizer()..onTap = onTap,
                    style: Style.commonTextStyle(
                      color: primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
