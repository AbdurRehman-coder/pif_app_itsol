import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    required this.imageProfile,
    required this.userName,
    required this.userPosition,
    this.isFromGuest = false,
    super.key,
  });

  final String imageProfile;
  final String userName;
  final String userPosition;
  final bool isFromGuest;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.w,
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
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: Style.commonTextStyle(
                color: darkTextColor,
                fontSize: isFromGuest ? 16.sp : 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              userPosition,
              style: Style.commonTextStyle(
                color: silverTextColor,
                fontSize: isFromGuest ? 14.sp : 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
