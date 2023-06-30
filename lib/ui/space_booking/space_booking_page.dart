import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/space_booking/index.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
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
  Widget build(BuildContext context) {
    final provider = ref.watch(spaceBookingProvider);
    final notifier = ref.read(spaceBookingProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: grayF5,
      appBar: AppBar(
        toolbarHeight:
            (provider.filterDataString != null && provider.filterDataString!.isNotEmpty) ? 120.h : 100.h,
        backgroundColor: grayF5,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w, top: context.statusBarHeight),
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
              ).visibility(visible: provider.filterDataString!.isNotEmpty),
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
                          await showFilterPopup(
                            context: context,
                          );
                          await notifier.getSpaceAsync(isFilter: true);
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
      floatingActionButton: Align(
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
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(
                      S.current.instanceBooking,
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
                child: InkWell(
                  onTap: () {
                    AppRouter.pushNamed(Routes.bookingScannerScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.scanner,
                        height: 18.h,
                        colorFilter: const ColorFilter.mode(
                          textColor,
                          BlendMode.srcIn,
                        ),
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
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FocusDetector(
        onFocusGained: notifier.getSpaceAsync,
        child: Container(
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
                return setListView(data, notifier);
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
      ),
    );
  }

  Widget setListView(List<RoomModel> data, SpaceBookingNotifier notifier) {
    return RefreshIndicator(
      onRefresh: () async {
        notifier.searchController.clear();
        notifier.clearFilterData();
        await notifier.getSpaceAsync();
      },
      child: ListView.separated(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 100.h),
        itemBuilder: (context, index) {
          return SpaceBookingListTile(item: data[index]);
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
        final provider = ref.watch(filterByProvider);
        return DefaultDayTile(
          date: date,
          onTap: onTap,
          selectedDayColor: primaryColor,
          currentDayBorderColor: primaryColor,
          selectedDateCount: provider.selectedDateList.length,
          selectedDateList: provider.selectedDateList,
        );
      },
    );
  }
}
