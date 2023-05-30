import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/ui/booking/popup/booking_details_popup.dart';
import 'package:pif_flutter/ui/booking/provider/booking_provider.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_style.dart';
import 'package:pif_flutter/widgets/dotindicator.dart';

class BookingPage extends ConsumerStatefulWidget {
  const BookingPage({
    required this.spaceData,
    super.key,
  });

  final RoomModel spaceData;

  @override
  ConsumerState createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(bookingProvider.notifier).getBookings(roomId: widget.spaceData.id);
    });
  }

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
            bookingDetailsBottomSheet(context: context, spaceData: widget.spaceData);
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
                  colorFilter: const ColorFilter.mode(borderColor, BlendMode.srcIn),
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
            height: context.topHeaderHeight.h,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  itemCount: 3,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: context.topHeaderHeight.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage(Assets.spaceBg1), fit: BoxFit.fill),
                      ),
                    );
                  },
                ),
                Column(
                  children: [
                    SizedBox(
                      height: context.statusBarHeight.h,
                    ),
                    SizedBox(
                      height: 10.h,
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
                      widget.spaceData.name ?? '',
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
                          '${widget.spaceData.capacity} seats huddle',
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
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
                  ],
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
                      colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                      height: 5.h,
                      width: 5.w,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: context.containerTopMargin.h),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
            ),
            child: _calendarDayView(),
          )
        ],
      ),
    );
  }

  Widget _calendarDayView() {
    final notifier = ref.read(bookingProvider.notifier);
    final provider = ref.watch(bookingProvider);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.calendar,
                colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              ),
              SizedBox(
                width: 7.w,
              ),
              Text(
                'Dec 2023',
                style: Style.commonTextStyle(
                  color: primaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Container(
                height: 30.h,
                width: 90.w,
                decoration: BoxDecoration(
                  border: Border.all(color: darkBorderColor),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Today',
                  style: Style.commonTextStyle(
                    color: darkBorderColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 50.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: provider.lstDays.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: context.screenWidth / 7,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      notifier.updateDays(index: index);
                    },
                    child: Container(
                      width: 33.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: provider.lstDays[index].bgColor,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            provider.lstDays[index].dayName ?? '',
                            style: Style.commonTextStyle(
                              color: dayTextColor,
                              fontSize: provider.lstDays[index].textFontSize.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            provider.lstDays[index].dayDate ?? '',
                            style: Style.commonTextStyle(
                              color: textColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        Expanded(
          child: TimePlanner(
            startTime: provider.startTime,
            endTime: provider.endTime,
            startHour: 0,
            endHour: 24,
            tasks: provider.lstTasks,
            style: TimePlannerStyle(
              cellHeight: 60,
              showScrollBar: true,
              interstitialEvenColor: Colors.grey[50],
              interstitialOddColor: Colors.grey[200],
            ),
          ),
        ),
      ],
    );
  }
}
