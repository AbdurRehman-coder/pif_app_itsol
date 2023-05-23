import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/extensions/context_extensions.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/ui/booking/popup/add_visitor_popup.dart';
import 'package:pif_flutter/ui/booking/popup/booking_confirmation_popup.dart';
import 'package:pif_flutter/ui/booking/provider/booking_provider.dart';
import 'package:pif_flutter/ui/space_booking/model/space_booking_model.dart';
import 'package:pif_flutter/ui/space_booking/space_booking_page.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/widgets/time_picker_popup.dart';
import 'package:pif_flutter/widgets/widget_extensions.dart';

void bookingDetailsBottomSheet({
  required BuildContext context,
  required SpaceBookingModel spaceData,
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
          return KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              if (isKeyboardVisible) {
                Future.delayed(Duration.zero, () {
                  controller.animateTo(
                    300,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                });
              }
              return SizedBox(
                height: context.screenHeight - 180.h,
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
                                child: TextField(
                                  controller: notifier.titleController,
                                  maxLength: 100,
                                  decoration: Style.floatingTextFieldDecoration(
                                    text: S.current.bookingTitle,
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
                                  ),
                                  Visibility(
                                    visible: provider.isOpenDatePicker,
                                    child: Container(
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
                                  ),
                                  Visibility(
                                    visible: provider.isOpenStartTimePicker,
                                    child: TimePickerPopup(
                                      timeData: provider.startTime ?? DateTime.now(),
                                      onCancel: notifier.closeStartTimePickerDialog,
                                      onConfirm: (selectedTime) {
                                        notifier.updateStartTime(startTime: selectedTime);
                                        notifier.closeStartTimePickerDialog();
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: provider.isOpenEndTimePicker,
                                    child: TimePickerPopup(
                                      timeData: provider.endTime ?? DateTime.now(),
                                      onCancel: notifier.closeEndTimePickerDialog,
                                      onConfirm: (selectedTime) {
                                        notifier.updateEndTime(endTime: selectedTime);
                                        notifier.closeEndTimePickerDialog();
                                      },
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
                                child: TextField(
                                  controller: notifier.addGuestController,
                                  onChanged: notifier.searchGuest,
                                  decoration: Style.floatingTextFieldDecoration(
                                    text: S.current.addGuest,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 18.h),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Wrap(
                                        spacing: 6,
                                        runSpacing: 6,
                                        children:
                                            List<Widget>.generate(provider.lstGuests.length, (int index) {
                                          return Container(
                                            width: 110.w,
                                            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.h),
                                            decoration: BoxDecoration(
                                              color: grayF5,
                                              border: Border.all(
                                                color: grayTextColor,
                                                width: 1.w,
                                              ),
                                              borderRadius: BorderRadius.circular(14.r),
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 75.w,
                                                  child: Text(
                                                    provider.lstGuests[index].fullName ?? '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: Style.commonTextStyle(
                                                      color: darkBorderColor,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    notifier.removeGuest(provider.lstGuests[index]);
                                                  },
                                                  child: SvgPicture.asset(
                                                    Assets.close,
                                                    height: 15.h,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 220.h,
                                    margin: EdgeInsets.symmetric(horizontal: 18.sp),
                                    padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 10,
                                          color: grayE3,
                                        ),
                                      ],
                                    ),
                                    child: provider.lstAutoCompleteGuests.isNotEmpty
                                        ? ListView.separated(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  notifier.addGuest(provider.lstAutoCompleteGuests[index]);
                                                },
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 40.h,
                                                      width: 40.w,
                                                      decoration: BoxDecoration(
                                                        color: grayC0,
                                                        borderRadius: BorderRadius.circular(20.r),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 16.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          provider.lstAutoCompleteGuests[index].fullName ??
                                                              '',
                                                          style: Style.commonTextStyle(
                                                            color: darkTextColor,
                                                            fontSize: 16.sp,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          provider.lstAutoCompleteGuests[index].email ?? '',
                                                          style: Style.commonTextStyle(
                                                            color: silverTextColor,
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // const Spacer(),
                                                    // InkWell(
                                                    //   onTap: () {
                                                    //     notifier.removeGuest(provider.lstAutoCompleteGuests[index]);
                                                    //   },
                                                    //   child: SvgPicture.asset(Assets.close),
                                                    // )
                                                  ],
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return Divider(
                                                height: 15.h,
                                                thickness: 1.h,
                                                color: borderColor,
                                              );
                                            },
                                            itemCount: provider.lstAutoCompleteGuests.length,
                                          )
                                        : Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              SizedBox(
                                                height: 30.h,
                                              ),
                                              SvgPicture.asset(Assets.emptyGuestBg),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                S.of(context).noMatchingResultFound,
                                                textAlign: TextAlign.center,
                                                style: Style.commonTextStyle(
                                                  color: textColor,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ).visibility(visible: provider.isVisibleAddGuestList),
                                  // Padding(
                                  //   padding: EdgeInsets.symmetric(horizontal: 18.sp),
                                  //   child: provider.lstGuests.isNotEmpty
                                  //       ? ListView.separated(
                                  //           shrinkWrap: true,
                                  //           physics: const NeverScrollableScrollPhysics(),
                                  //           itemBuilder: (context, index) {
                                  //             return Row(
                                  //               children: [
                                  //                 Container(
                                  //                   height: 40.h,
                                  //                   width: 40.w,
                                  //                   decoration: BoxDecoration(
                                  //                     color: grayC0,
                                  //                     borderRadius: BorderRadius.circular(20.r),
                                  //                   ),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   width: 16.w,
                                  //                 ),
                                  //                 Column(
                                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                                  //                   children: [
                                  //                     Text(
                                  //                       provider.lstGuests[index].fullName ?? '',
                                  //                       style: Style.commonTextStyle(
                                  //                         color: darkTextColor,
                                  //                         fontSize: 16.sp,
                                  //                         fontWeight: FontWeight.w400,
                                  //                       ),
                                  //                     ),
                                  //                     Text(
                                  //                       provider.lstGuests[index].email ?? '',
                                  //                       style: Style.commonTextStyle(
                                  //                         color: silverTextColor,
                                  //                         fontSize: 14.sp,
                                  //                         fontWeight: FontWeight.w400,
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //                 const Spacer(),
                                  //                 InkWell(
                                  //                   onTap: () {
                                  //                     notifier.removeGuest(provider.lstGuests[index]);
                                  //                   },
                                  //                   child: SvgPicture.asset(Assets.close),
                                  //                 )
                                  //               ],
                                  //             );
                                  //           },
                                  //           separatorBuilder: (context, index) {
                                  //             return Divider(
                                  //               height: 15.h,
                                  //               thickness: 1.h,
                                  //               color: borderColor,
                                  //             );
                                  //           },
                                  //           itemCount: provider.lstGuests.length,
                                  //         )
                                  //       : Column(
                                  //           children: [
                                  //             SizedBox(
                                  //               height: 30.h,
                                  //             ),
                                  //             SvgPicture.asset(Assets.emptyGuestBg),
                                  //             SizedBox(
                                  //               height: 10.h,
                                  //             ),
                                  //             Text(
                                  //               S.of(context).noMatchingResultFound,
                                  //               style: Style.commonTextStyle(
                                  //                 color: textColor,
                                  //                 fontSize: 16.sp,
                                  //                 fontWeight: FontWeight.w400,
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 100.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.sp),
                                child: ElevatedButton(
                                  onPressed: () {
                                    AppRouter.pop();
                                    bookingConfirmationPopup(
                                      context: context,
                                      isRequestBooking: spaceData.isRequestToApprove,
                                    );
                                  },
                                  style: Style.primaryButtonStyle(
                                    context: context,
                                  ),
                                  child: Text(
                                    spaceData.btnTitle,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
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
          );
        },
      );
    },
  );
}
