import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:dixels_sdk/features/commerce/rooms/models/room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/search_text_field.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/space_booking/index.dart';

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
    ref.read(spaceBookingProvider.notifier).getSpaceAsync();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(spaceBookingProvider);
    final notifier = ref.read(spaceBookingProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightGrayBgColor,
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
        title: SearchTextField(
          textEditingController: notifier.searchController,
          onChanged: notifier.searchData,
          fillColor: Colors.white,
          hintText: S.current.searchSpaces,
          hintTextStyle: Style.commonTextStyle(
            color: hintColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w, left: 5.w),
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: activeBgColor,
              ),
              height: 40.h,
              width: 40.w,
              child: const Icon(
                Icons.history,
                color: dayTextColor,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h, right: 16.w, left: 16.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).availableRoom,
                  style: Style.commonTextStyle(
                    color: blackColorWith900,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await showFilterPopup(
                      context: context,
                    );
                    await notifier.getSpaceAsync(isFilter: true);
                  },
                  child: Icon(
                    Icons.filter_list,
                    size: 24.sp,
                    color: primaryColor,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Expanded(
              child: provider.lstData.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const SpaceBookingEmptyView();
                  } else {
                    return setListView(data, notifier);
                  }
                },
                error: (error, stackTrace) {
                  return SizedBox(
                    height: 10.h,
                  );
                },
                loading: () {
                  return const SpaceBookingShimmerWidget();
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: whiteColor.withOpacity(0.70),
        padding: EdgeInsets.only(bottom: 16.w),
        height: 72.h,
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.instant,
                    height: 16.h,
                    width: 16.w,
                    colorFilter: const ColorFilter.mode(textColor, BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    S.current.instanceBooking,
                    style: Style.commonTextStyle(
                      color: textColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 28.h,
              width: 1,
              color: hintColor,
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
                      height: 16.h,
                      width: 16.w,
                      colorFilter: const ColorFilter.mode(
                        textColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      S.current.scanToBook,
                      style: Style.commonTextStyle(
                        color: textColor,
                        fontSize: 14.sp,
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
        // padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 100.h),
        itemBuilder: (context, index) {
          return SpaceBookingListTile(
            item: data[index],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20.h,
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
