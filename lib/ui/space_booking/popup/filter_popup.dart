import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/date_picker_widget.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/ui/space_booking/index.dart';
import 'package:pif_flutter/ui/space_booking/widget/capacity_view.dart';
import 'package:pif_flutter/ui/space_booking/widget/floor_list_view.dart';
import 'package:pif_flutter/widgets/time_picker_popup.dart';

Future<void> showFilterPopup({required BuildContext context}) async {
  await showModalBottomSheet(
    backgroundColor: whiteColor,
    isScrollControlled: true,
    useRootNavigator: true,
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
          return GestureDetector(
            onTap: () {
              if (provider.isOpenStartDatePicker) {
                notifier.closeStartDatePicker();
              }
              if (provider.isOpenEndDatePicker) {
                notifier.closeEndDatePicker();
              }
              if (provider.isOpenStartTimePicker) {
                notifier.closeStartTimePickerDialog();
              }

              if (provider.isOpenEndTimePicker) {
                notifier.closeEndTimePickerDialog();
              }
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height.h - 230.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
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
                                  S.of(context).filters,
                                  style: Style.commonTextStyle(
                                    color: filterTextColor,
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
                            height: 8.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              S.of(context).str_start,
                              style: Style.commonTextStyle(
                                color: blackColorWith900.withOpacity(0.60),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: notifier.openStartDatePicker,
                                        child: Theme(
                                          data: ThemeData(
                                            disabledColor: textColor,
                                          ),
                                          child: SecondCustomTextField(
                                            textEditingController:
                                                notifier.startDateController,
                                            hintText: S.of(context).date,
                                            checkEmpty: true,
                                            enabled: false,
                                            fillColor: whiteColor,
                                            borderRadius: 6.r,
                                            textFieldBorderColor:
                                                textFieldBorderColor,
                                            contentPadding: EdgeInsets.only(
                                                bottom: 8.h,
                                                left: 12.w,
                                                right: 12.w),
                                            hintFontSize: 14.sp,
                                            hintTextColor: blackColorWith900
                                                .withOpacity(0.45),
                                            suffixIcon: SvgPicture.asset(
                                              Assets.calenderTodaySvg,
                                              fit: BoxFit.scaleDown,
                                              colorFilter: ColorFilter.mode(
                                                blackColorWith900
                                                    .withOpacity(0.45),
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap:
                                            notifier.openStartTimePickerDialog,
                                        child: Theme(
                                          data: ThemeData(
                                            disabledColor: textColor,
                                          ),
                                          child: SecondCustomTextField(
                                            textEditingController:
                                                notifier.startTimeController,
                                            hintText: S.of(context).time,
                                            fillColor: whiteColor,
                                            enabled: false,
                                            checkEmpty: true,
                                            textFieldBorderColor:
                                                textFieldBorderColor,
                                            borderRadius: 6.r,
                                            contentPadding: EdgeInsets.only(
                                                bottom: 8.h,
                                                left: 12.w,
                                                right: 12.w),
                                            hintFontSize: 14.sp,
                                            hintTextColor: blackColorWith900
                                                .withOpacity(0.45),
                                            suffixIcon: Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 22.sp,
                                              color: blackColorWith900
                                                  .withOpacity(0.45),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: provider.isOpenStartDatePicker,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.h, right: 16.w, left: 16.w),
                                  child: DatePickerWidget(
                                    selectedDate: provider.startDate,
                                    onConfirm: notifier.updateStartDate,
                                    onCancel: notifier.closeStartDatePicker,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 60.h, right: 16.w, left: 16.w),
                                child: InkWell(
                                  onTap: () {},
                                  child: TimePickerPopup(
                                    timeData:
                                        provider.startTime ?? DateTime.now(),
                                    onCancel:
                                        notifier.closeStartTimePickerDialog,
                                    onConfirm: (selectedTime) {
                                      notifier.updateStartTime(
                                          startTime: selectedTime);
                                      notifier.closeStartTimePickerDialog();
                                    },
                                  ).visibility(
                                      visible: provider.isOpenStartTimePicker),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              S.of(context).str_end,
                              style: Style.commonTextStyle(
                                color: blackColorWith900.withOpacity(0.60),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: notifier.openEndDatePicker,
                                        child: Theme(
                                          data: ThemeData(
                                            disabledColor: textColor,
                                          ),
                                          child: SecondCustomTextField(
                                            textEditingController:
                                                notifier.endDateController,
                                            hintText: S.of(context).date,
                                            checkEmpty: true,
                                            enabled: false,
                                            fillColor: whiteColor,
                                            borderRadius: 6.r,
                                            textFieldBorderColor:
                                                textFieldBorderColor,
                                            contentPadding: EdgeInsets.only(
                                                bottom: 8.h,
                                                left: 12.w,
                                                right: 12.w),
                                            hintFontSize: 14.sp,
                                            hintTextColor: blackColorWith900
                                                .withOpacity(0.45),
                                            suffixIcon: SvgPicture.asset(
                                              Assets.calenderTodaySvg,
                                              height: 20.h,
                                              width: 20.w,
                                              fit: BoxFit.scaleDown,
                                              colorFilter: ColorFilter.mode(
                                                blackColorWith900
                                                    .withOpacity(0.45),
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: notifier.openEndTimePickerDialog,
                                        child: Theme(
                                          data: ThemeData(
                                            disabledColor: textColor,
                                          ),
                                          child: SecondCustomTextField(
                                            textEditingController:
                                                notifier.endTimeController,
                                            hintText: S.of(context).time,
                                            fillColor: whiteColor,
                                            enabled: false,
                                            checkEmpty: true,
                                            textFieldBorderColor:
                                                textFieldBorderColor,
                                            borderRadius: 6.r,
                                            contentPadding: EdgeInsets.only(
                                                bottom: 8.h,
                                                left: 12.w,
                                                right: 12.w),
                                            hintFontSize: 14.sp,
                                            hintTextColor: blackColorWith900
                                                .withOpacity(0.45),
                                            suffixIcon: Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 22.sp,
                                              color: blackColorWith900
                                                  .withOpacity(0.45),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: provider.isOpenEndDatePicker,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 10.h, right: 16.w, left: 16.w),
                                  child: DatePickerWidget(
                                    selectedDate: provider.endDate,
                                    onConfirm: notifier.updateEndDate,
                                    onCancel: notifier.closeEndDatePicker,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 60.h, right: 16.w, left: 16.w),
                                child: InkWell(
                                  onTap: () {},
                                  child: TimePickerPopup(
                                    timeData:
                                        provider.endTime ?? DateTime.now(),
                                    onCancel: notifier.closeEndTimePickerDialog,
                                    onConfirm: (selectedTime) {
                                      notifier.updateEndTime(
                                          endTime: selectedTime,
                                          context: context);
                                      notifier.closeEndTimePickerDialog();
                                    },
                                  ).visibility(
                                      visible: provider.isOpenEndTimePicker),
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
                          Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Text(
                              S.of(context).floor,
                              style: Style.commonTextStyle(
                                color: textColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          FloorListView(
                            lstFloors: provider.lstFloors,
                            notifier: notifier,
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
                          CapacityView(
                            provider: provider,
                            notifier: notifier,
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 16.w, left: 16.w, bottom: 40.h),
                            child: ElevatedButton(
                              onPressed: AppRouter.pop,
                              style: Style.primaryButtonStyle(context: context),
                              child: Text(S.of(context).showFilterRooms),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
