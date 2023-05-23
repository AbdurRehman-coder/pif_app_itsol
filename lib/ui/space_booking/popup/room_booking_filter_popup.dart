import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/extensions/context_extensions.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/ui/space_booking/provider/room_booking_filter_provider.dart';
import 'package:pif_flutter/ui/space_booking/space_booking_page.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/widgets/time_picker_popup.dart';

void roomBookingFilterBottomSheet({
  required BuildContext context,
}) {
  showModalBottomSheet<dynamic>(
    context: context,
    backgroundColor: whiteColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
    ),
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final provider = ref.watch(roomBookingProvider);
          final notifier = ref.read(roomBookingProvider.notifier);
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50.h),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    Assets.downArrow,
                    height: 13.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.sp),
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 22.h,
                          ),
                          Row(
                            children: [
                              Text(
                                S.of(context).dateTime,
                                style: Style.commonTextStyle(
                                  color: textColor,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                S.of(context).reset,
                                style: Style.commonTextStyle(
                                  color: primaryColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Stack(
                            children: [
                              InkWell(
                                onTap: notifier.openDatePickerDialog,
                                child: Theme(
                                  data: ThemeData(
                                    disabledColor: textColor,
                                  ),
                                  child: TextField(
                                    controller: notifier.dateController,
                                    enabled: false,
                                    decoration: Style.floatingTextFieldDecoration(
                                      text: S.current.date,
                                      suffixIcon: SvgPicture.asset(
                                        Assets.calendar,
                                        height: 10.h,
                                        width: 10.w,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: provider.isOpenDatePicker,
                                child: Container(
                                  margin: EdgeInsets.only(top: 50.h),
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                  height: 400.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: grayE3,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: AwesomeCalendar(
                                          selectedDates: provider.selectedDates.toList(),
                                          selectionMode: SelectionMode.multi,
                                          startDate: DateTime.now(),
                                          endDate: DateTime.now().add(const Duration(days: 50)),
                                          dayTileBuilder: CustomDayTileBuilder(),
                                          onTap: notifier.updateDateString,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: notifier.closeDatePickerDialog,
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              foregroundColor: primaryColor,
                                              backgroundColor: Colors.white,
                                            ),
                                            child: Center(
                                              child: Text(
                                                S.of(context).cancel,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                            onPressed: notifier.closeDatePickerDialog,
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: primaryColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                S.of(context).confirm,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Container(
                            height: 1.h,
                            color: grayBorderColor,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Stack(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: notifier.openStartTimePickerDialog,
                                      child: Theme(
                                        data: ThemeData(
                                          disabledColor: textColor,
                                        ),
                                        child: TextField(
                                          controller: notifier.startTimeController,
                                          enabled: false,
                                          decoration: Style.floatingTextFieldDecoration(
                                            text: S.current.startingTime,
                                            suffixIcon: SvgPicture.asset(
                                              Assets.arrowDown,
                                              height: 10.h,
                                              width: 10.w,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Text(
                                    '-',
                                    style: Style.commonTextStyle(
                                      color: blackColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: notifier.openEndTimePickerDialog,
                                      child: Theme(
                                        data: ThemeData(
                                          disabledColor: textColor,
                                        ),
                                        child: TextField(
                                          controller: notifier.endTimeController,
                                          enabled: false,
                                          decoration: Style.floatingTextFieldDecoration(
                                            text: S.current.endingTime,
                                            suffixIcon: SvgPicture.asset(
                                              Assets.arrowDown,
                                              height: 10.h,
                                              width: 10.w,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: provider.isOpenStartTimePicker,
                                child: Container(
                                  margin: EdgeInsets.only(top: 50.h),
                                  child: TimePickerPopup(
                                    timeData: DateTime.now(),
                                    onCancel: notifier.closeStartTimePickerDialog,
                                    onConfirm: (selectedTime) {
                                      notifier.updateStartTime(startTime: selectedTime);
                                      notifier.closeStartTimePickerDialog();
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 50.h),
                                child: Visibility(
                                  visible: provider.isOpenEndTimePicker,
                                  child: TimePickerPopup(
                                    timeData: DateTime.now(),
                                    onCancel: notifier.closeEndTimePickerDialog,
                                    onConfirm: (selectedTime) {
                                      notifier.updateEndTime(endTime: selectedTime);
                                      notifier.closeEndTimePickerDialog();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: whiteColor,
                                  fixedSize: Size(110.w, 40.h),
                                  elevation: 0,
                                  side: const BorderSide(color: primaryColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r), // <-- Radius
                                  ),
                                ),
                                child: Text(
                                  S.of(context).showAll,
                                  style: Style.commonTextStyle(
                                    color: primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: whiteColor,
                                  backgroundColor: primaryColor,
                                  fixedSize: Size(context.screenWidth.w - 165.w, 40.h),
                                  side: const BorderSide(color: primaryColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r), // <-- Radius
                                  ),
                                ),
                                child: const Text(
                                  'Show(41) rooms',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    },
  );
}
