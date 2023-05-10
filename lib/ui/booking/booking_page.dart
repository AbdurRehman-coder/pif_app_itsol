import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/extensions/context_extensions.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/ui/booking/popup/booking_details_popup.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/widgets/dotindicator.dart';

class BookingPage extends ConsumerStatefulWidget {
  const BookingPage({
    super.key,
  });

  @override
  ConsumerState createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: lightPrimaryColor,
        ),
        height: 80.h,
        child: InkWell(
          onTap: () {
            bookingDetailsBottomSheet(context: context);
          },
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
                S.of(context).dragForBookingDetails,
                style: Style.commonTextStyle(
                  color: textColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: Platform.isIOS ? 280.h : 240.h,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: Platform.isIOS ? 280.h : 240.h,
                      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 12.h),
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage(Assets.spaceBg1), fit: BoxFit.fill),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: context.statusBarHeight.h,
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
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
                                width: 10.w,
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
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    margin: EdgeInsets.only(bottom: 35.h),
                    child: SizedBox(
                      height: 20.h,
                      child: DotsIndicator(
                        selectedColor: primaryColor,
                        unselectedColor: grayBorderColor,
                        controller: _controller,
                        itemCount: 3,
                        onPageSelected: (int page) {
                          _controller.animateToPage(
                            page,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: AppRouter.pop,
                  child: Container(
                    margin: EdgeInsets.only(top: context.statusBarHeight.h, left: 16.w, right: 16.w),
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: lightGoldenColor,
                      borderRadius: BorderRadius.circular(
                        20.r,
                      ),
                    ),
                    child: SvgPicture.asset(
                      Assets.back,
                      fit: BoxFit.scaleDown,
                      color: primaryColor,
                      height: 5.h,
                      width: 5.w,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Platform.isIOS ? 255.h : 220.h),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
            ),
          )
        ],
      ),
    );
  }
}
