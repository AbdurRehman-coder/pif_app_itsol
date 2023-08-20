import 'dart:io';

import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/date_picker_widget.dart';
import 'package:pif_flutter/common/shared/widget/search_text_field.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking/index.dart';
import 'package:pif_flutter/widgets/time_picker_popup.dart';

class BookingPage extends ConsumerStatefulWidget {
  const BookingPage({
    required this.spaceData,
    required this.isFromScan,
    required this.isFromSpace,
    this.bookingModel,
    super.key,
  });

  final RoomModel spaceData;
  final bool isFromScan;
  final bool isFromSpace;
  final BookingModel? bookingModel;

  @override
  ConsumerState createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        if (widget.bookingModel != null) {
          ref
              .read(bookingProvider.notifier)
              .bindEditData(spaceData: widget.bookingModel!, context: context);
          ref
              .read(bookingProvider.notifier)
              .getBookings(spaceData: widget.bookingModel!.roomModel);
          ref.read(bookingProvider.notifier).roomModel =
              widget.bookingModel?.roomModel;
        } else {
          ref
              .read(bookingProvider.notifier)
              .getBookings(spaceData: widget.spaceData);
          ref.read(bookingProvider.notifier).roomModel = widget.spaceData;
        }

        if (widget.isFromScan) {
          ref.read(bookingProvider.notifier).bindScanData();
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(bookingProvider);
    final notifier = ref.read(bookingProvider.notifier);

    return Scaffold(
      backgroundColor: lightGrayBgColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: lightGrayBgColor,
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w, left: 5.w),
            child: InkWell(
              onTap: () {
                AppRouter.pushNamed(
                  Routes.bookingCalenderScreen,
                  args: [widget.spaceData, false],
                );
              },
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: activeBgColor,
                ),
                height: 40.h,
                width: 40.w,
                child: SvgPicture.asset(
                  Assets.calenderTodaySvg,
                ),
              ),
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          if (provider.isOpenStartDatePicker) {
            notifier.closeStartDatePickerDialog();
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
        child: Form(
          key: notifier.formKey,
          child: KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              if (isKeyboardVisible && notifier.addGuestFocus.hasFocus) {
                Future.delayed(Duration.zero, () {
                  notifier.controller.animateTo(
                    300,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                });
              }
              return SingleChildScrollView(
                controller: notifier.controller,
                padding: EdgeInsets.only(top: 24.h, right: 16.w, left: 16.w),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SecondCustomTextField(
                          textEditingController: notifier.titleController,
                          focusNode: notifier.titleFocus,
                          textFieldBorderColor: textFieldBorderColor,
                          hintText: S.of(context).bookingSubject,
                          fillColor: whiteColor,
                          borderRadius: 6.r,
                          checkEmpty: true,
                          hintFontSize: 14.sp,
                          hintTextColor: blackColorWith900.withOpacity(0.45),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          S.of(context).dateAndTime,
                          style: Style.commonTextStyle(
                            color: blackColorWith900,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          S.of(context).str_start,
                          style: Style.commonTextStyle(
                            color: blackColorWith900.withOpacity(0.60),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: notifier.openStartDatePickerDialog,
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
                                    isFocus: provider.isOpenStartDatePicker,
                                    isDateAndTime: true,
                                    fillColor: whiteColor,
                                    borderRadius: 6.r,
                                    textFieldBorderColor: textFieldBorderColor,
                                    contentPadding: EdgeInsets.only(
                                      bottom: 8.h,
                                      left: 12.w,
                                      right: 12.w,
                                    ),
                                    hintFontSize: 14.sp,
                                    hintTextColor:
                                        blackColorWith900.withOpacity(0.45),
                                    suffixIcon: SvgPicture.asset(
                                      Assets.calenderTodaySvg,
                                      fit: BoxFit.scaleDown,
                                      colorFilter: ColorFilter.mode(
                                        blackColorWith900.withOpacity(0.45),
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
                                onTap: notifier.openStartTimePickerDialog,
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
                                    isFocus: provider.isOpenStartTimePicker,
                                    isDateAndTime: true,
                                    checkEmpty: true,
                                    textFieldBorderColor: textFieldBorderColor,
                                    borderRadius: 6.r,
                                    contentPadding: EdgeInsets.only(
                                      bottom: 8.h,
                                      left: 12.w,
                                      right: 12.w,
                                    ),
                                    hintFontSize: 14.sp,
                                    hintTextColor:
                                        blackColorWith900.withOpacity(0.45),
                                    suffixIcon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 22.sp,
                                      color:
                                          blackColorWith900.withOpacity(0.45),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          S.of(context).str_end,
                          style: Style.commonTextStyle(
                            color: blackColorWith900.withOpacity(0.60),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: notifier.openEndDatePickerDialog,
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
                                    isFocus: provider.isOpenEndDatePicker,
                                    isDateAndTime: true,
                                    fillColor: whiteColor,
                                    borderRadius: 6.r,
                                    textFieldBorderColor: textFieldBorderColor,
                                    contentPadding: EdgeInsets.only(
                                      bottom: 8.h,
                                      left: 12.w,
                                      right: 12.w,
                                    ),
                                    hintFontSize: 14.sp,
                                    hintTextColor:
                                        blackColorWith900.withOpacity(0.45),
                                    suffixIcon: SvgPicture.asset(
                                      Assets.calenderTodaySvg,
                                      height: 20.h,
                                      width: 20.w,
                                      fit: BoxFit.scaleDown,
                                      colorFilter: ColorFilter.mode(
                                        blackColorWith900.withOpacity(0.45),
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
                                    isFocus: provider.isOpenEndTimePicker,
                                    isDateAndTime: true,
                                    textFieldBorderColor: textFieldBorderColor,
                                    borderRadius: 6.r,
                                    contentPadding: EdgeInsets.only(
                                      bottom: 8.h,
                                      left: 12.w,
                                      right: 12.w,
                                    ),
                                    hintFontSize: 14.sp,
                                    hintTextColor:
                                        blackColorWith900.withOpacity(0.45),
                                    suffixIcon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 22.sp,
                                      color:
                                          blackColorWith900.withOpacity(0.45),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: S.of(context).guests,
                                    style: Style.commonTextStyle(
                                      color: textColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ${S.of(context).optional}',
                                    style: Style.commonTextStyle(
                                      color: textColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                addVisitorBottomSheet(
                                  context: context,
                                  provider: provider,
                                  notifier: notifier,
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 20.sp,
                                    color: primaryColor,
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Text(
                                    S.of(context).newGuest,
                                    style: Style.commonTextStyle(
                                      color: primaryColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        SearchTextField(
                          textEditingController: notifier.addGuestController,
                          focusNode: notifier.addGuestFocus,
                          hintText: S.of(context).searchGuest,
                          textFieldBorderRadius: 6.r,
                          contentPadding: EdgeInsets.only(
                            left: 12.w,
                            right: 12.w,
                            top: 30.h,
                          ),
                          fillColor: whiteColor,
                          onChanged: notifier.searchGuest,
                          height: 50.h,
                          hintTextStyle: Style.commonTextStyle(
                            color: blackColorWith900.withOpacity(0.45),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: darkBorderColor,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        AddGuestView(
                          provider: provider,
                          notifier: notifier,
                        ),
                        if (isKeyboardVisible) ...[
                          SizedBox(
                            height: 200.h,
                          ),
                        ],
                        SizedBox(
                          height: Platform.isIOS ? 40.h : 20.h,
                        )
                      ],
                    ),
                    Visibility(
                      visible: provider.isOpenStartDatePicker,
                      child: Padding(
                        padding: EdgeInsets.only(top: 130.h),
                        child: DatePickerWidget(
                          selectedDate: provider.startDate,
                          onConfirm: notifier.updateStartDate,
                          onCancel: notifier.closeStartDatePickerDialog,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 180.h),
                      child: TimePickerPopup(
                        timeData: provider.startTime ?? DateTime.now(),
                        onCancel: notifier.closeStartTimePickerDialog,
                        onConfirm: (selectedTime) {
                          notifier.updateStartTime(
                            startTime: selectedTime,
                          );
                          notifier.closeStartTimePickerDialog();
                        },
                      ).visibility(
                        visible: provider.isOpenStartTimePicker,
                      ),
                    ),
                    Visibility(
                      visible: provider.isOpenEndDatePicker,
                      child: Padding(
                        padding: EdgeInsets.only(top: 215.h),
                        child: DatePickerWidget(
                          selectedDate: provider.endDate,
                          onConfirm: notifier.updateEndDate,
                          onCancel: notifier.closeEndDatePicker,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 265.h),
                      child: TimePickerPopup(
                        timeData: provider.endTime ?? DateTime.now(),
                        onCancel: notifier.closeEndTimePickerDialog,
                        onConfirm: (selectedTime) {
                          notifier.updateEndTime(
                            endTime: selectedTime,
                            context: context,
                          );
                          notifier.closeEndTimePickerDialog();
                        },
                      ).visibility(visible: provider.isOpenEndTimePicker),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 48.h,
        color: lightGrayBgColor,
        margin: EdgeInsets.only(bottom: 40.h, right: 16.w, left: 16.w),
        child: ElevatedButton(
          onPressed: () {
            if (widget.bookingModel != null) {
              notifier.bookNowAsync(
                context: context,
                isBookEnabled: false,
                roomId: widget.bookingModel!.id!,
                isFromSpace: false,
                isFromScan: widget.isFromScan,
              );
            } else {
              notifier.bookNowAsync(
                context: context,
                isBookEnabled: widget.spaceData.needApproval!,
                roomId: widget.spaceData.id!,
                isFromSpace: widget.isFromSpace,
                isFromScan: widget.isFromScan,
              );
            }
          },
          style: Style.primaryButtonStyle(
            context: context,
          ),
          child: Text(
            S.current.bookNow,
          ),
        ),
      ),
    );
  }
}
