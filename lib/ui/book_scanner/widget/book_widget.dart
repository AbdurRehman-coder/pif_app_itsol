import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/ui/space_booking/model/space_booking_model.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({required this.spaceBookingModel, super.key});

  final SpaceBookingModel spaceBookingModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 222.h,
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 12.h),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(spaceBookingModel.backImage!),
          fit: BoxFit.fitWidth,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Building 2  -  Floor 1',
            style: Style.commonTextStyle(
              color: whiteColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 22.h,
          ),
          Text(
            spaceBookingModel.spaceName ?? '',
            style: Style.commonTextStyle(
              color: whiteColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              SvgPicture.asset(
                Assets.chair,
                height: 16.h,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                '2 seats huddle',
                style: Style.commonTextStyle(
                  color: whiteColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 22.h,
          ),
          Row(
            children: [
              SvgPicture.asset(
                Assets.videoConf,
                height: 18.h,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                'Video conferencing',
                style: Style.commonTextStyle(
                  color: whiteColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          ElevatedButton(
            onPressed: () => AppRouter.pushNamed(Routes.bookingScreen),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r), // <-- Radius
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.of(context).book,
                  textAlign: TextAlign.center,
                  style: Style.commonTextStyle(
                    color: whiteColor,
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
  }
}
