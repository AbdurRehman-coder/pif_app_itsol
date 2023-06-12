import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

void deleteMessagePopup({
  required BuildContext context,
  required String deleteMessage,
  required void Function()? onClickYes,
  void Function()? onClickNo,
}) {
  showModalBottomSheet<dynamic>(
    backgroundColor: whiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 25.h, bottom: 40.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.alert,
            ),
            SizedBox(height: 20.h),
            Text(
              deleteMessage,
              style: Style.commonTextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: blackColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 54.w,
                      vertical: 9.h,
                    ),
                  ),
                  onPressed: onClickYes,
                  child: Text(
                    S.of(context).yeah,
                    style: Style.commonTextStyle(
                      color: whiteColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 5.w),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 54.w,
                      vertical: 9.h,
                    ),
                  ),
                  onPressed: onClickNo ?? AppRouter.pop,
                  child: Text(
                    S.of(context).no,
                    style: Style.commonTextStyle(
                      color: primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
