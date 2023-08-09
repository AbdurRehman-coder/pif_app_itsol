import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/utils/colors.dart';

void alertMessage({
  required String errorMessage,
  required BuildContext context,
  AlertStatusEnum statusEnum = AlertStatusEnum.error,
  TextStyle? errorMessageStyle,
  int? secondDuration,
  Curve curves = Curves.elasticOut,
  Curve reverseCurve = Curves.easeInSine,
}) {
  final bgColor =
      statusEnum == AlertStatusEnum.error ? pinkColor : lightPrimaryColor;
  final textColor =
      statusEnum == AlertStatusEnum.error ? dangerousColor : primaryColor;
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
          side: BorderSide(
            color: textColor,
            width: .8,
          ),
        ),
        color: statusEnum == AlertStatusEnum.success ? activeBgColor : bgColor,
      ),
      child: Row(
        children: [
          if (statusEnum == AlertStatusEnum.success) ...[
            const Icon(
              Icons.done,
              color: primaryColor,
            )
          ] else ...[
            SvgPicture.asset(
              Assets.warningIcon,
              width: 18.w,
              height: 20.h,
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
            ),
          ],
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              errorMessage,
              style: errorMessageStyle ??
                  TextStyle(
                    color: statusEnum == AlertStatusEnum.success
                        ? primaryColor
                        : textColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
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

enum AlertStatusEnum { error, success }
