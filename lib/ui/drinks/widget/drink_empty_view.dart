import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';

class DrinkEmptyView extends StatelessWidget {
  const DrinkEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Assets.emptySearchBgImage,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
          child: Column(
            children: [
              SvgPicture.asset(
                Assets.drinkEmpty,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                S.of(context).noDrinkToShow,
                textAlign: TextAlign.center,
                style: Style.commonTextStyle(
                  color: primaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                S.of(context).cantFindMatchingResult,
                textAlign: TextAlign.center,
                style: Style.commonTextStyle(
                  color: textColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
