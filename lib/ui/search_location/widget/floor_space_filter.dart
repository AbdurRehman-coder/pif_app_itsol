import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class FloorSpaceFilter extends StatelessWidget {
  const FloorSpaceFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              // height: 48.h,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(
                  6.r,
                ),
                border: Border.all(
                  color: grayBgColor,
                  width: 1.r,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).floor,
                          style: Style.commonTextStyle(
                            color: grayA0,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          S.of(context).baseCamp,
                          style: Style.commonTextStyle(
                            color: textColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: grayA0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
          child: Container(
            // height: 48.h,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(
                6.r,
              ),
              border: Border.all(
                color: grayBgColor,
                width: 1.r,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).spaceType,
                        style: Style.commonTextStyle(
                          color: grayA0,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        S.of(context).desk,
                        style: Style.commonTextStyle(
                          color: textColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: grayA0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
