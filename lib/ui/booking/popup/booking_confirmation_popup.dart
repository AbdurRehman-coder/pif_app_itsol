import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

void bookingConfirmationPopup({required BuildContext context}) {
  showModalBottomSheet<dynamic>(
    backgroundColor: whiteColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 355.h,
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Align(
                  child: SvgPicture.asset(
                    Assets.bookConfirmation,
                  ),
                ),
                InkWell(
                  onTap: AppRouter.pop,
                  child: Text(
                    S.of(context).skip,
                    style: Style.commonTextStyle(
                      color: primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              S.of(context).bookingRoom,
              style: Style.commonTextStyle(
                color: textColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: S.of(context).bookedByMistake,
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: Style.commonTextStyle(
                      color: grayTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: S.of(context).cancel,
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: Style.commonTextStyle(
                      color: redColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
