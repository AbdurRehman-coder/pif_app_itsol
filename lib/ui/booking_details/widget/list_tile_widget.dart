import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    required this.imageProfile,
    required this.userName,
    required this.userPosition,
    super.key,
  });

  final String imageProfile;
  final String userName;
  final String userPosition;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 45.h,
          width: 45.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                imageProfile,
              ),
              fit: BoxFit.fitWidth,
            ),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: Style.commonTextStyle(
                color: blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              userPosition,
              style: Style.commonTextStyle(
                color: darkBorderColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
