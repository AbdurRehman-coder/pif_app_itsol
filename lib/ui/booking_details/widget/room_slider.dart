import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/widgets/dotindicator.dart';

class RoomSlider extends StatefulWidget {
  const RoomSlider({
    required this.pageController,
    super.key,
  });

  final PageController pageController;

  @override
  State<RoomSlider> createState() => _RoomSliderState();
}

class _RoomSliderState extends State<RoomSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: Stack(
        children: [
          PageView.builder(
            controller: widget.pageController,
            itemCount: 3,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(
                  top: 60.h,
                  bottom: 20.h,
                  right: 20.w,
                  left: 20.w,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.spaceBg1),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Building 2  -  Floor 1',
                style: Style.commonTextStyle(
                  color: whiteColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Al Multaqa 301',
                style: Style.commonTextStyle(
                  color: whiteColor,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.chair,
                    height: 16.h,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    '2 seats huddle',
                    style: Style.commonTextStyle(
                      color: whiteColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.videoConf,
                    height: 18.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'Video conferencing',
                    style: Style.commonTextStyle(
                      color: whiteColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Container(
                    height: 10.h,
                    width: 1.w,
                    color: whiteColor,
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  SvgPicture.asset(
                    Assets.screenCast,
                    height: 18.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    S.of(context).screenSharing,
                    style: Style.commonTextStyle(
                      color: whiteColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 20.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: SizedBox(
                  height: 20.h,
                  child: DotsIndicator(
                    selectedColor: primaryColor,
                    unselectedColor: grayBorderColor,
                    controller: widget.pageController,
                    itemCount: 3,
                    onPageSelected: (int page) {
                      widget.pageController.animateToPage(
                        page,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
