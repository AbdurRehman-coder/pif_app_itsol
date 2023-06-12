import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

void scanHelpBottomSheet({required BuildContext context}) {
  showModalBottomSheet<dynamic>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),

    // <= this is set to 3/4 of screen size.
    isScrollControlled: true,
    // <= set to true. setting this without constrains may cause full screen bottomsheet.

    context: context,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25.w,
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SizedBox(height: 35.h),
              SvgPicture.asset(
                Assets.qrcode,
                width: 150.w,
                height: 150.h,
              ),
              SizedBox(height: 32.h),
              Center(
                child: Text(
                  S.of(context).scanQRCodeToBook,
                  style: Style.commonTextStyle(
                    color: blackColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                S.of(context).scanHelpMessage,
                textAlign: TextAlign.center,
                style: Style.commonTextStyle(
                  color: grayTextColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: ElevatedButton(
                  onPressed: AppRouter.pop,
                  child: Text(
                    S.of(context).gotIt,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
