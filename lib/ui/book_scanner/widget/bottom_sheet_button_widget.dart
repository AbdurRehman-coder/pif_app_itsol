import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetButtonWidget extends StatelessWidget {
  final String bottomText;
  final void Function() onTap;

  const BottomSheetButtonWidget({
    required this.bottomText,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: lightPrimaryColor,
        ),
        height: 80.h,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                Assets.downArrow,
                color: borderColor,
                height: 13.h,
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            Text(
              bottomText,
              style: TextStyle(
                color: textColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
