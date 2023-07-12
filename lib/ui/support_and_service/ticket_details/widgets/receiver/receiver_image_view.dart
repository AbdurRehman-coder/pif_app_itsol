import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/widgets/custom_image.dart';

class ReceiverImageView extends StatelessWidget {
  const ReceiverImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: CustomImage(
            height: 24.h,
            width: 24.w,
            image: const NetworkImage('https://randomuser.me/api/portraits/men/41.jpg'),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 176.w,
              height: 160.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: expireBgColor,
                border: Border.all(color: grayBorderColor),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: CustomImage(
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(16.r),
                image: const NetworkImage('https://picsum.photos/200/300'),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                '12:30 PM',
                style: Style.commonTextStyle(
                  color: dayTextColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
