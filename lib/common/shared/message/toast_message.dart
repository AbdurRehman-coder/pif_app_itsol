import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/utils/colors.dart';

void errorMessage({
  required String errorMessage,
  required BuildContext context,
  TextStyle? errorMessageStyle,
  int? secondDuration,
  Curve curves = Curves.elasticOut,
  Curve reverseCurve = Curves.easeInSine,
}) {
  showToastWidget(
    Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0.w,
        vertical: 12.h,
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0.w),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0.r),
        ),
        color: pinkColor,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.warningIcon,
            width: 18.w,
            height: 20.h,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              errorMessage,
              style: errorMessageStyle ??
                  TextStyle(
                    color: dangerousColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    ),
    context: context,
    animation: StyledToastAnimation.slideFromTop,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.top,
    animDuration: const Duration(seconds: 1),
    duration: Duration(seconds: secondDuration ?? 3),
    curve: curves,
    reverseCurve: reverseCurve,
  );
}
