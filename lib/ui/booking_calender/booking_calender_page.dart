import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking/index.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_style.dart';

class BookingCalenderPage extends ConsumerStatefulWidget {
  const BookingCalenderPage({required this.spaceData, required this.isFromBooking, super.key});

  final RoomModel spaceData;
  final bool isFromBooking;

  @override
  ConsumerState createState() => _BookingCalenderPageState();
}

class _BookingCalenderPageState extends ConsumerState<BookingCalenderPage> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        ref.read(bookingProvider.notifier).getBookings(spaceData: widget.spaceData);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(bookingProvider);
    final notifier = ref.read(bookingProvider.notifier);
    return Scaffold(
      backgroundColor: expireBgColor,
      appBar: AppBar(
        backgroundColor: expireBgColor,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: AppRouter.pop,
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: activeBgColor,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: dayTextColor,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          'Book ${widget.spaceData.name}',
          style: Style.commonTextStyle(
            color: textColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 30.h,
              width: 69.w,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: lightPrimaryColor,
              ),
              child: Text(
                'Today',
                style: Style.commonTextStyle(
                  color: dayTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 31.h),
              decoration: BoxDecoration(
                color: whiteColor,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, -2),
                    blurRadius: 4,
                    color: Color.fromRGBO(39, 38, 39, 0.04),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 55.h,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      provider.lstDays[index].dayDate ?? '',
                                      style: Style.commonTextStyle(
                                        color: provider.lstDays[index].isSelected!
                                            ? provider.lstDays[index].bgColor
                                            : textColor,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      provider.lstDays[index].dayName ?? '',
                                      style: Style.commonTextStyle(
                                        color: provider.lstDays[index].isSelected!
                                            ? provider.lstDays[index].bgColor
                                            : dayTextColor,
                                        fontSize: provider.lstDays[index].textFontSize.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Container(
                                      height: 6.h,
                                      width: 6.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: provider.lstDays[index].bgColor,
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
                        dividerColor: whiteColor,
                        interstitialEvenColor: Colors.grey[50],
                        interstitialOddColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: FloatingActionButton(
          onPressed: () {
            AppRouter.pushReplacement(Routes.bookingScreen, args: [widget.spaceData, false]);
          },
          elevation: 0,
          child: Icon(
            Icons.add,
            size: 22.sp,
            color: whiteColor,
          ),
        ),
      ).visibility(visible: widget.isFromBooking == true),
    );
  }
}
