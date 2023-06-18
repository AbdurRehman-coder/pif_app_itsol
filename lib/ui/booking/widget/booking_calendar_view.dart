import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/booking/index.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_style.dart';

class BookingCalendarView extends StatelessWidget {
  const BookingCalendarView({required this.provider, required this.notifier, super.key});

  final BookingState provider;
  final BookingNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.containerTopMargin.h),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: _calendarDayView(),
    );
  }

  Widget _calendarDayView() {
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
