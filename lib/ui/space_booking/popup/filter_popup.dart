import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/ui/space_booking/index.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/widgets/time_picker_popup.dart';
import 'package:pif_flutter/widgets/time_picker_widget.dart';

Future<void> showFilterPopup({required BuildContext context}) async {
  await showModalBottomSheet<dynamic>(
    backgroundColor: whiteColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
    ),
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final provider = ref.watch(filterByProvider);
          final notifier = ref.read(filterByProvider.notifier);
          return SizedBox(
            height: MediaQuery.of(context).size.height.h - 230.h,
            child: Column(
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Center(
                  child: SvgPicture.asset(
                    Assets.downArrow,
                    height: 13.h,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 23.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
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
                              InkWell(
                                onTap: notifier.resetFilter,
                                child: Text(
                                  S.of(context).reset,
                                  style: Style.commonTextStyle(
                                    color: primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        InkWell(
                          onTap: notifier.openDialog,
                          child: Container(
                            height: 40.h,
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            decoration: BoxDecoration(
                              color: lightGrayBgColor,
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                color: borderColor,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    provider.selectedDateString.isEmpty
                                        ? S.current.datesAndRepeat
                                        : provider.selectedDateString,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Style.commonTextStyle(
                                      color: provider.selectedDateString.isEmpty ? grayTextColor : textColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                  Assets.calendar,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 24.h,
                                ),
                                Container(
                                  height: 1.h,
                                  color: grayBorderColor,
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 18.sp),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: notifier.openStartTimePickerDialog,
                                          child: Theme(
                                            data: ThemeData(
                                              disabledColor: textColor,
                                            ),
                                            child: CustomTextField(
                                              textEditingController: notifier.startTimeController,
                                              enabled: false,
                                              checkEmpty: true,
                                              labelText: S.current.startingTime,
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
                                            child: CustomTextField(
                                              textEditingController: notifier.endTimeController,
                                              enabled: false,
                                              checkEmpty: true,
                                              labelText: S.current.endingTime,
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
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  height: 1.h,
                                  color: grayBorderColor,
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).filters,
                                        style: Style.commonTextStyle(
                                          color: textColor,
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.floor,
                                            height: 22,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            S.of(context).floor,
                                            style: Style.commonTextStyle(
                                              color: textColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                  height: 40.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: provider.lstFloors.length,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: 8.w,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          notifier.updateFloorList(index: index);
                                        },
                                        child: Container(
                                          height: 40.h,
                                          margin: index == 0
                                              ? EdgeInsets.only(left: 10.w)
                                              : EdgeInsets.only(left: 0.w),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                          ),
                                          decoration: BoxDecoration(
                                            color: provider.lstFloors[index].backgroundColor,
                                            border: Border.all(
                                              color: provider.lstFloors[index].borderColor!,
                                            ),
                                            borderRadius: BorderRadius.circular(8.r),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            provider.lstFloors[index].floorName ?? '',
                                            style: Style.commonTextStyle(
                                              color: provider.lstFloors[index].textColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  height: 1.h,
                                  color: grayBorderColor,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        Assets.capacity,
                                        height: 22,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        S.of(context).capacity,
                                        style: Style.commonTextStyle(
                                          color: textColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: notifier.removeCapacity,
                                        child: SvgPicture.asset(
                                          Assets.minus,
                                          height: 33.h,
                                        ),
                                      ),
                                      Container(
                                        width: 55.w,
                                        alignment: Alignment.center,
                                        child: Text(
                                          provider.capacity.toString(),
                                          style: Style.commonTextStyle(
                                            color: hintColor,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: notifier.addCapacity,
                                        child: SvgPicture.asset(
                                          Assets.plus,
                                          height: 33.h,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                Container(
                                  height: 1.h,
                                  color: grayBorderColor,
                                ),
                                SizedBox(
                                  height: 17.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: ElevatedButton(
                                    onPressed: AppRouter.pop,
                                    style: Style.primaryButtonStyle(context: context),
                                    child: Text(S.of(context).showFilterRooms),
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                              ],
                            ),
                            Visibility(
                              visible: provider.isOpenPopup,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
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
                                        selectedDates: provider.selectedDateList.toList(),
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
                                          onPressed: notifier.closeDialog,
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
                                          onPressed: notifier.closeDialog,
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
                            Visibility(
                              visible: provider.isOpenStartTimePicker,
                              child: Container(
                                margin: EdgeInsets.only(top: 100.h),
                                child: TimePickerPopup(
                                  timeData: provider.startTime,
                                  onCancel: notifier.closeStartTimePickerDialog,
                                  onConfirm: (selectedTime) {
                                    notifier.updateStartTime(startTime: selectedTime);
                                    notifier.closeStartTimePickerDialog();
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: provider.isOpenEndTimePicker,
                              child: Container(
                                margin: EdgeInsets.only(top: 100.h),
                                child: TimePickerPopup(
                                  timeData: provider.endTime,
                                  onCancel: notifier.closeEndTimePickerDialog,
                                  onConfirm: (selectedTime) {
                                    notifier.updateEndTime(endTime: selectedTime);
                                    notifier.closeEndTimePickerDialog();
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: provider.isOpenTimePicker,
                              child: TimePickerWidget(
                                startTime: provider.startTime,
                                endTime: provider.endTime,
                                onCancel: notifier.closeTimePickerDialog,
                                onConfirm: (startTime, endTime) {
                                  notifier.updateTime(
                                    startTime: startTime,
                                    endTime: endTime,
                                  );
                                  notifier.closeTimePickerDialog();
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
