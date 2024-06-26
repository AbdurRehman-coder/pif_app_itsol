import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class SpaceBookingEmptyView extends StatelessWidget {
  SpaceBookingEmptyView({this.isFromEdit, super.key});

  bool? isFromEdit = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w),
      child: Column(
        children: [
          SvgPicture.asset(
            Assets.noBooking,
          ),
          SizedBox(
            height: 10.h,
          ),
          if (isFromEdit == true) ...[
            Text(
              S.current.noBookingAvailable,
              textAlign: TextAlign.center,
              style: Style.commonTextStyle(
                color: primaryColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
          SizedBox(
            height: 3.h,
          ),
          Text(
            S.of(context).cantFindMatchingResult,
            textAlign: TextAlign.center,
            style: Style.commonTextStyle(
              color: textColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
