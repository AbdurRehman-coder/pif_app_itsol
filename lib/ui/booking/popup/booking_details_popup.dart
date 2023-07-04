import 'dart:io';

import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/ui/booking/index.dart';
import 'package:pif_flutter/widgets/time_picker_popup.dart';

void bookingDetailsBottomSheet({
  required BuildContext context,
  required RoomModel spaceData,
}) {
  final controller = ScrollController();
  showModalBottomSheet<dynamic>(
    backgroundColor: whiteColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
    ),
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final provider = ref.watch(bookingProvider);
          final notifier = ref.read(bookingProvider.notifier);
          return GestureDetector(
            onTap: () {
              if (provider.isOpenDatePicker) {
                notifier.closeDatePickerDialog();
              }

              if (provider.isOpenStartTimePicker) {
                notifier.closeStartTimePickerDialog();
              }

              if (provider.isOpenEndTimePicker) {
                notifier.closeEndTimePickerDialog();
              }
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Form(
              key: notifier.formKey,
              child: KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
                  if (isKeyboardVisible && notifier.addGuestFocus.hasFocus) {
                    Future.delayed(Duration.zero, () {
                      controller.animateTo(
                        300,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    });
                  }
                  return SizedBox(
                    height: context.screenHeight - 150.h,
                    child: Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            S.of(context).roomCalendar,
                            style: Style.commonTextStyle(
                              color: primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Center(
                            child: SvgPicture.asset(
                              Assets.downArrow,
                              height: 13.h,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: controller,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 22.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 18.sp),
                                    child: CustomTextField(
                                      textEditingController: notifier.titleController,
                                      maxLength: 100,
                                      checkEmpty: true,
                                      labelText: S.current.bookingTitle,
                                      focusNode: notifier.titleFocus,
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
                                    height: 24.h,
                                  ),
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 18.sp),
                                        child: InkWell(
                                          onTap: notifier.openDatePickerDialog,
                                          child: Theme(
                                            data: ThemeData(
                                              disabledColor: textColor,
                                            ),
                                            child: CustomTextField(
                                              textEditingController: notifier.dateController,
                                              checkEmpty: true,
                                              enabled: false,
                                              isFocus: provider.isOpenDatePicker,
                                              suffixIcon: SvgPicture.asset(
                                                Assets.calendar,
                                                height: 10.h,
                                                width: 10.w,
                                                fit: BoxFit.scaleDown,
                                              ),
                                              labelText: S.current.date,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 50.h),
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
                                        child: InkWell(
                                          onTap: () {},
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: AwesomeCalendar(
                                                  selectedDates: provider.selectedDates.toList(),
                                                  selectionMode: SelectionMode.multi,
                                                  startDate: DateTime.now(),
                                                  endDate: DateTime.now().add(const Duration(days: 30)),
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
                                                    onPressed: () {
                                                      notifier.cancel();
                                                      notifier.closeDatePickerDialog();
                                                    },
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
                                                    onPressed: () {
                                                      notifier.confirm();
                                                      notifier.closeDatePickerDialog();
                                                    },
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
                                      ).visibility(visible: provider.isOpenDatePicker),
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
                                                    isFocus: provider.isOpenStartTimePicker,
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
                                                    isFocus: provider.isOpenEndTimePicker,
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
                                      Container(
                                        margin: EdgeInsets.only(top: 50.h),
                                        child: InkWell(
                                          onTap: () {},
                                          child: TimePickerPopup(
                                            timeData: provider.startTime ?? DateTime.now(),
                                            onCancel: notifier.closeStartTimePickerDialog,
                                            onConfirm: (selectedTime) {
                                              notifier.updateStartTime(startTime: selectedTime);
                                              notifier.closeStartTimePickerDialog();
                                            },
                                          ).visibility(visible: provider.isOpenStartTimePicker),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 50.h),
                                        child: InkWell(
                                          onTap: () {},
                                          child: TimePickerPopup(
                                            timeData: provider.endTime ?? DateTime.now(),
                                            onCancel: notifier.closeEndTimePickerDialog,
                                            onConfirm: (selectedTime) {
                                              notifier.updateEndTime(endTime: selectedTime, context: context);
                                              notifier.closeEndTimePickerDialog();
                                            },
                                          ).visibility(visible: provider.isOpenEndTimePicker),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  InkWell(
                                    onTap: AppRouter.pop,
                                    child: Text(
                                      S.of(context).selectTimeOnRoomCalendar,
                                      style: Style.commonTextStyle(
                                        color: primaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
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
                                    height: 24.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 18.sp),
                                    child: Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: DefaultTextStyle.of(context).style,
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: S.of(context).guest,
                                                style: Style.commonTextStyle(
                                                  color: textColor,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const TextSpan(text: ' '),
                                              TextSpan(
                                                text: S.of(context).optional,
                                                style: Style.commonTextStyle(
                                                  color: textColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        SvgPicture.asset(
                                          Assets.user,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            addVisitorBottomSheet(
                                              context: context,
                                              provider: provider,
                                              notifier: notifier,
                                            );
                                          },
                                          child: Text(
                                            S.of(context).newVisitors,
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
                                    height: 10.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 18.sp),
                                    child: CustomTextField(
                                      textEditingController: notifier.addGuestController,
                                      onChanged: notifier.searchGuest,
                                      labelText: S.current.addGuest,
                                      focusNode: notifier.addGuestFocus,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  AddGuestView(
                                    provider: provider,
                                    notifier: notifier,
                                  ),
                                  SizedBox(
                                    height: 100.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 18.sp),
                                    child: ElevatedButton(
                                      onPressed: () => notifier.bookNowAsync(
                                        context: context,
                                        isBookEnabled: spaceData.needApproval!,
                                        roomId: spaceData.id!,
                                      ),
                                      style: Style.primaryButtonStyle(
                                        context: context,
                                      ),
                                      child: Text(
                                        S.current.book,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Platform.isIOS ? 40.h : 20.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    },
  );
}

class CustomDayTileBuilder extends DayTileBuilder {
  CustomDayTileBuilder();

  @override
  Widget build(
    BuildContext context,
    DateTime date,
    void Function(DateTime datetime)? onTap,
  ) {
    return Consumer(
      builder: (context, ref, child) {
        final provider = ref.watch(bookingProvider);
        return DefaultDayTile(
          date: date,
          onTap: onTap,
          selectedDayColor: primaryColor,
          currentDayBorderColor: primaryColor,
          selectedDateCount: provider.selectedDates.length,
          selectedDateList: provider.selectedDates,
        );
      },
    );
  }
}
