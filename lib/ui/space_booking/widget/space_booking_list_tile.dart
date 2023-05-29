import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class SpaceBookingListTile extends StatelessWidget {
  const SpaceBookingListTile({required this.item, super.key});

  final RoomModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(Assets.spaceBg2),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
            height: 24.h,
          ),
          Text(
            item.name ?? '',
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
                '${item.capacity} seats huddle',
                style: Style.commonTextStyle(
                  color: whiteColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 28.h,
          ),
          if (item.amenities != null) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(
                item.amenities!.length,
                (int index) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Assets.videoConf,
                        height: 16.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        item.amenities![index].name ?? '',
                        style: Style.commonTextStyle(
                          color: whiteColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Container(
                        height: 9.h,
                        width: 1.w,
                        color: grayBorderColor,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
          SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
            onPressed: () {
              AppRouter.pushNamed(Routes.bookingScreen, args: item);
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(context.screenWidth.w, 35.h),
              backgroundColor: item.bookable ?? false ? whiteColor : primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r), // <-- Radius
              ),
            ),
            child: Text(
              item.bookable ?? false ? S.current.requestToBook : S.current.book,
              style: Style.commonTextStyle(
                color: item.bookable ?? false ? primaryColor : whiteColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
