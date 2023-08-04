import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class CongratsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(6, (index) {
        return Row(
          children: [
            Flexible(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Congrats ',
                      style: Style.commonTextStyle(
                        color: dayTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: 'Neom',
                      style: Style.commonTextStyle(
                        color: darkBlueColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    TextSpan(
                      text: ' team on the new project!',
                      style: Style.commonTextStyle(
                        color: dayTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
