import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/widgets/custom_image.dart';

class SenderVideoView extends StatelessWidget {
  const SenderVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 176.w,
          height: 160.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: primaryColor,
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
        Text(
          '12:30 PM',
          style: Style.commonTextStyle(
            color: dayTextColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
