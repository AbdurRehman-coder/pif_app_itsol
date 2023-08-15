import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';

class EmptyNotification extends StatelessWidget {
  const EmptyNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            SvgPicture.asset(
              Assets.emptyNotification,
              width: 192.w,
              height: 192.h,
            ),
            SizedBox(height: 15.h),
            Text(
              S.current.noNotificationToShow,
              style: Style.commonTextStyle(
                color: primaryColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              S.current.noNotificationsDemandYourAttention,
              style: Style.commonTextStyle(
                color: blackColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
