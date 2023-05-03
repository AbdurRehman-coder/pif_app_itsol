import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/ui/space_booking/model/space_booking_model.dart';
import 'package:pif_flutter/ui/space_booking/provider/space_booking_provider.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

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
          toolbarHeight: 115.h,
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
                SizedBox(
                  height: 5.h,
                ),
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
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        Assets.filter,
                        height: 20.h,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5.h),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(30.w), topRight: Radius.circular(30.w)),
              ),
              child: provider.lstData.when(
                data: setListView,
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
            Container(
              height: 50.h,
              margin: EdgeInsets.only(bottom: 24.h, left: 60.w, right: 60.w),
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(Assets.tabBg), fit: BoxFit.fitWidth),
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
                          color: textColor,
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
                  )
                ],
              ),
            )
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
            height: 220.h,
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 12.h),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(data[index].backImage!), fit: BoxFit.fitWidth),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 22.h,
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
                  height: 22.h,
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
                  height: 10.h,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r), // <-- Radius
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        S.of(context).book,
                        textAlign: TextAlign.center,
                        style: Style.commonTextStyle(
                          color: whiteColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
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
}
