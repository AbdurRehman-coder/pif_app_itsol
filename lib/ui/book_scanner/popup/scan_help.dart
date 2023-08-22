import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/book_scanner/provider/scan_booking_list_provider.dart';

void scanHelpBottomSheet({
  required BuildContext context,
  required ScanBookingListNotifier notifier,
}) {
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
          Container(
            height: 5.h,
            width: 67.w,
            margin: EdgeInsets.only(top: 16.h),
            decoration: BoxDecoration(
              color: dividerColor,
              borderRadius: BorderRadius.circular(6.h),
            ),
          ).toCenter(),
          SizedBox(
            height: 24.h,
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
          Padding(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            child: GestureDetector(
              onTap: () => notifier.setScannedFirstTime(false),
              child: Container(
                height: 48.h,
                width: context.screenWidth,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: greenBorderColor,
                  ),
                ),
                child: Text(
                  S.of(context).gotIt,
                  style: Style.commonTextStyle(
                    color: whiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
        ],
      );
    },
  );
}
