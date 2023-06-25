import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';

void scanHelpBottomSheet({required BuildContext context}) {
  showModalBottomSheet<dynamic>(
    useSafeArea: true,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 35.h,
          ),
          SvgPicture.asset(
            Assets.qrcode,
            width: 192.w,
            height: 192.h,
          ),
          SizedBox(
            height: 32.h,
          ),
          Text(
            S.of(context).scanQRCodeToBook,
            textAlign: TextAlign.center,
            style: Style.commonTextStyle(
              color: textColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Text(
              S.of(context).scanHelpMessage,
              textAlign: TextAlign.center,
              style: Style.commonTextStyle(
                color: grayTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          ElevatedButton(
            onPressed: AppRouter.pop,
            style: Style.primaryButtonStyle(
              context: context,
              width: 172.w,
            ),
            child: Text(
              S.of(context).gotIt,
              style: Style.commonTextStyle(
                color: whiteColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      );
    },
  );
}
