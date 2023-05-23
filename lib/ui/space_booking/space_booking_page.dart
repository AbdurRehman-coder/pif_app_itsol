import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/extensions/context_extensions.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/book_scanner/book_scanner_view.dart';
import 'package:pif_flutter/ui/space_booking/model/space_booking_model.dart';
import 'package:pif_flutter/ui/space_booking/provider/filter_by_provider.dart';
import 'package:pif_flutter/ui/space_booking/provider/space_booking_provider.dart';
import 'package:pif_flutter/ui/space_booking/space_booking_empty_view.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/widgets/time_picker_widget.dart';
import 'package:pif_flutter/widgets/widget_extensions.dart';

class SpaceBookingPage extends ConsumerStatefulWidget {
  const SpaceBookingPage({
    super.key,
  });

  @override
  ConsumerState createState() => _SpaceBookingPageState();
}

class _SpaceBookingPageState extends ConsumerState<SpaceBookingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // roomBookingFilterBottomSheet(context: context);
      ref.read(spaceBookingProvider.notifier).getSpaceData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(spaceBookingProvider);
    final notifier = ref.read(spaceBookingProvider.notifier);
    return SafeArea(
      child: Scaffold(
        backgroundColor: grayF5,
        appBar: AppBar(
          toolbarHeight:
              (provider.filterDataString != null && provider.filterDataString!.isNotEmpty) ? 120.h : 100.h,
          backgroundColor: grayF5,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: AppRouter.pop,
                      icon: SvgPicture.asset(
                        Assets.back,
                        height: 14.h,
                      ),
                    ),
                    Text(
                      S.current.spaceBooking,
                      style: Style.commonTextStyle(
                        color: blackColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 46.w),
                  child: Row(
                    children: [
                      Text(
                        provider.filterDataString ?? '',
                        style: Style.commonTextStyle(
                          color: dayTextColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Container(
                        height: 10.h,
                        width: 1.w,
                        color: hintColor,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      SvgPicture.asset(
                        Assets.chair,
                        height: 16.h,
                        colorFilter: const ColorFilter.mode(dayTextColor, BlendMode.srcIn),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        provider.filterData?.capacity ?? '',
                        style: Style.commonTextStyle(
                          color: dayTextColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ).visibility(visible: provider.filterData != null),
                Row(
                  children: [
                    SizedBox(
                      width: 15.w,
                    ),
                    Expanded(
                      child: Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: borderColor,
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              Assets.search,
                              height: 22.h,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              child: TextField(
                                controller: notifier.searchController,
                                onChanged: notifier.searchData,
                                style: Style.commonTextStyle(
                                  color: textColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: Style.inputDecoration(
                                  text: S.of(context).search,
                                  hintColor: hintColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await showFilterPopup();
                            notifier.updateFilterData();
                          },
                          icon: SvgPicture.asset(
                            Assets.filter,
                            height: 20.h,
                            colorFilter: ColorFilter.mode(
                              provider.filterData != null ? primaryColor : textColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        Container(
                          height: 20.h,
                          width: 20.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: lightPrimaryColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '+1',
                            style: Style.commonTextStyle(
                              color: primaryColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ).visibility(visible: provider.filterData != null)
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5.h),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.w),
                  topRight: Radius.circular(30.w),
                ),
              ),
              child: provider.lstData.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const SpaceBookingEmptyView();
                  } else {
                    return setListView(data);
                  }
                },
                error: (e, s) {
                  return SizedBox(
                    height: 10.h,
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50.h,
                margin: EdgeInsets.only(bottom: 24.h, left: 60.w, right: 60.w),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.tabBg),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.instant,
                            height: 18.h,
                            colorFilter: const ColorFilter.mode(textColor, BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 11.h),
                    width: 1,
                    color: whiteColor,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () =>
                          AppRouter.pushNamed(Routes.bookingScannerScreen),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.scanner,
                            height: 18.h,
                            color: textColor,
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Text(
                            S.current.scanToBook,
                            style: Style.commonTextStyle(
                              color: blackColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 11.h),
                      width: 1,
                      color: whiteColor,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.scanner,
                            height: 18.h,
                            colorFilter: const ColorFilter.mode(textColor, BlendMode.srcIn),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Text(
                            S.current.scanToBook,
                            style: Style.commonTextStyle(
                              color: blackColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setListView(List<SpaceBookingModel> data) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(data[index].backImage!),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Building 2  -  Floor 1',
                  style: Style.commonTextStyle(
                    color: whiteColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  data[index].spaceName ?? '',
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
                  height: 28.h,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.videoConf,
                      height: 18.h,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Video conferencing',
                      style: Style.commonTextStyle(
                        color: whiteColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    AppRouter.pushNamed(Routes.bookingScreen, args: data[index]);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(context.screenWidth.w, 35.h),
                    backgroundColor: data[index].btnBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r), // <-- Radius
                    ),
                  ),
                  child: Text(
                    data[index].btnTitle,
                    style: Style.commonTextStyle(
                      color: data[index].btnTitleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 15.h,
          );
        },
        itemCount: data.length,
      ),
    );
  }

  Future<void> showFilterPopup() async {
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
              height: MediaQuery.of(context).size.height.h - 180.h,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 25.h,
                    ),
                    Center(
                      child: SvgPicture.asset(
                        Assets.downArrow,
                        height: 13.h,
                      ),
                    ),
                    SizedBox(
                      height: 23.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        S.of(context).filterBy,
                        style: Style.commonTextStyle(
                          color: textColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
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
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.duration,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    S.of(context).duration,
                                    style: Style.commonTextStyle(
                                      color: textColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: notifier.openTimePickerDialog,
                                    child: Text(
                                      provider.timeString,
                                      style: Style.commonTextStyle(
                                        color: goldenColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              child: SizedBox(
                                height: 25.h,
                                child: Row(
                                  children: [
                                    const DottedLine(
                                      lineLength: 80,
                                      dashColor: grayD1,
                                    ),
                                    Expanded(
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          inactiveTrackColor: borderColor,
                                          activeTrackColor: primaryColor,
                                          thumbColor: primaryColor,
                                          overlayShape: SliderComponentShape.noThumb,
                                          showValueIndicator: ShowValueIndicator.always,
                                          thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 3.r,
                                          ),
                                          trackHeight: 1,
                                        ),
                                        child: RangeSlider(
                                          values: provider.rangeData,
                                          onChanged: (value) {
                                            notifier.updateRangeValue(
                                              rangeData: value,
                                            );
                                          },
                                          divisions: 40,
                                          // 15 Minutes Division Between 11:00 AM to 9:00 PM
                                          min: 660,
                                          // Minutes Of 11:00 AM
                                          max: 1260, //// Minutes Of 9:00 PM
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                children: [
                                  Text(
                                    '8:00 AM',
                                    style: Style.commonTextStyle(
                                      color: darkBorderColor,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Text(
                                    '11:00 AM',
                                    style: Style.commonTextStyle(
                                      color: textColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '9:00 PM',
                                    style: Style.commonTextStyle(
                                      color: textColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300,
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
                              child: Row(
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
                                      height: 22,
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
                                      height: 22,
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
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: notifier.resetFilter,
                                    child: Text(
                                      S.of(context).resetFilter,
                                      style: Style.commonTextStyle(
                                        color: primaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      '41 results found',
                                      style: Style.commonTextStyle(
                                        color: grayTextColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
            );
          },
        );
      },
    );
  }
}

class CustomDayTileBuilder extends DayTileBuilder {
  CustomDayTileBuilder();

  @override
  Widget build(
    BuildContext context,
    DateTime date,
    void Function(DateTime datetime)? onTap,
  ) {
    return DefaultDayTile(
      date: date,
      onTap: onTap,
      selectedDayColor: primaryColor,
      currentDayBorderColor: primaryColor,
    );
  }
}
